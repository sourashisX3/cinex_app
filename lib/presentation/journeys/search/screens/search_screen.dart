import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/utils/api_methods.dart';
import 'package:cinex_app/data/core/api_constants.dart';
import 'package:cinex_app/data/core/api_functions.dart';
import 'package:cinex_app/presentation/journeys/search/models/all_movies_res_model.dart';
import 'package:cinex_app/presentation/journeys/search/models/genre_res_api_model.dart';
import 'package:cinex_app/presentation/journeys/search/widgets/big_movie_card.dart';
import 'package:cinex_app/presentation/journeys/search/widgets/categories.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:cinex_app/presentation/widgets/SearchBars/app_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:cinex_app/presentation/libraries/AppUtilScreens/no_data_found.dart';
import 'package:cinex_app/presentation/libraries/AppContents/ProgressLibs/LoaderOverlay.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = -1;
  late Future _future;
  GenreResApiModel? _genreResApiModel;
  AllMoviesResModel? _allMoviesResModel;
  List<MovieResult> _displayedMovies = [];
  bool _isLoadingMovies = false;
  String _searchQuery = '';

  Future<GenreResApiModel?> _fetchGenres() async {
    try {
      final body = {'api_key': ApiConstants.apiKey, 'language': 'en-US'};
      final response = await ApiFun.apiRequestHttpRawBody(
        ApiConstants.genres,
        body,
        method: ApiMethods.get,
      );
      final res = GenreResApiModel.fromJson(response);
      // set the genres
      setState(() {
        _genreResApiModel = res;
      });
      return res;
    } catch (e) {
      debugPrint('Error fetching genres: $e');
      return null;
    }
  }

  Future<AllMoviesResModel?> _fetchMoviesByGenre(int genreId) async {
    try {
      setState(() {
        _isLoadingMovies = true;
      });

      final body = {'api_key': ApiConstants.apiKey, 'language': 'en-US'};
      final response = await ApiFun.apiRequestHttpRawBody(
        ApiConstants.moviesByGenre(genreId),
        body,
        method: ApiMethods.get,
      );

      final res = response != null
          ? AllMoviesResModel.fromJson(response)
          : null;
      setState(() {
        _allMoviesResModel = res;
        _displayedMovies = res?.results ?? [];
        _isLoadingMovies = false;
      });
      return res;
    } catch (e) {
      debugPrint('Error fetching movies by genre: $e');
      setState(() {
        _isLoadingMovies = false;
      });
      return null;
    }
  }

  Future<void> _refreshMovies() async {
    if (_selectedCategoryIndex < 0) {
      // nothing to refresh
      return;
    }
    await _fetchMoviesByGenre(_selectedCategoryIndex);
  }

  @override
  void initState() {
    // load genres first. movies will be loaded when a category is selected.
    _future = _fetchGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(AppStringConstants.searchMovies),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          // while loading genres
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: showSimpleLoaderOverlay());
          }

          // if no genres loaded or error
          if (_genreResApiModel == null ||
              (_genreResApiModel?.genres?.isEmpty ?? true)) {
            return NoDataFound(
              title: 'No categories found',
              subTitle: 'Please try again',
              onRefresh: () {
                setState(() {
                  _future = _fetchGenres();
                });
              },
            );
          }

          // Main content with refresh and search
          return RefreshIndicator(
            onRefresh: _refreshMovies,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: SafeArea(
                child: Padding(
                  padding: Sizes.paddingAll16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar with onChanged
                      FadeInDown(
                        child: AppSearchBar(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.trim();
                              if (_searchQuery.isEmpty) {
                                _displayedMovies =
                                    _allMoviesResModel?.results ?? [];
                              } else {
                                _displayedMovies =
                                    (_allMoviesResModel?.results ?? [])
                                        .where(
                                          (m) => (m.title ?? '')
                                              .toLowerCase()
                                              .contains(
                                                _searchQuery.toLowerCase(),
                                              ),
                                        )
                                        .toList();
                              }
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: Sizes.dimen_30),

                      // Categories list
                      FadeInLeft(
                        child: SizedBox(
                          height: Sizes.dimen_40,
                          child: ListView.builder(
                            itemCount: _genreResApiModel?.genres?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final genre = _genreResApiModel!.genres![index];
                              return Categories(
                                title: genre.name ?? 'Unknown',
                                isSelected: _selectedCategoryIndex == genre.id,
                                onTap: () async {
                                  final tappedId = genre.id ?? -1;
                                  setState(() {
                                    // toggle selection: deselect if same, else select
                                    if (_selectedCategoryIndex == tappedId) {
                                      _selectedCategoryIndex = -1;
                                      _allMoviesResModel = null;
                                      _displayedMovies = [];
                                    } else {
                                      _selectedCategoryIndex = tappedId;
                                    }
                                  });

                                  if (_selectedCategoryIndex >= 0) {
                                    await _fetchMoviesByGenre(
                                      _selectedCategoryIndex,
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      // movie list / states
                      const SizedBox(height: Sizes.dimen_20),

                      if (_selectedCategoryIndex < 0)
                        // initial state: no category selected
                        NoDataFound(
                          title: 'No category selected',
                          subTitle: 'Please pick a category to see movies',
                          onRefresh: () async {},
                        )
                      else if (_isLoadingMovies)
                        Center(child: showSimpleLoaderOverlay())
                      else if ((_displayedMovies.isEmpty))
                        NoDataFound(
                          title: 'No movies found',
                          subTitle: 'Try different category or search',
                          onRefresh: _refreshMovies,
                        )
                      else
                        FadeInUp(
                          preferences: AnimationPreferences(
                            duration: const Duration(seconds: 1),
                          ),
                          child: ListView.builder(
                            itemCount: _displayedMovies.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final m = _displayedMovies[index];
                              return BigMovieCard(
                                title: m.title ?? 'Untitled',
                                posterPath: m.posterPath,
                                backdropPath: m.backdropPath,
                                releaseDate: m.releaseDate,
                                voteAverage: m.voteAverage,
                                voteCount: m.voteCount,
                                overview: m.overview,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
