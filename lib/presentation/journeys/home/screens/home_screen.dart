import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/constants/strings/debugger_tags.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/data/core/api_constants.dart';
import 'package:cinex_app/data/core/api_functions.dart';
import 'package:cinex_app/presentation/journeys/details/screens/movie_details_screen.dart';
import 'package:cinex_app/presentation/journeys/home/models/movies_api_res_model.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/home_app_bar.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/movies_card.dart';
import 'package:cinex_app/presentation/libraries/AppContents/FlutterPageTransition/src/enum.dart';
import 'package:cinex_app/presentation/libraries/AppContents/ProgressLibs/LoaderOverlay.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:cinex_app/presentation/libraries/AppUtilScreens/no_data_found.dart';
import 'package:flutter/material.dart';
import '../../../../common/utils/api_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasError = false;
  String errorMessage = '';
  late Future _future;

  final List<MovieResult> _trendingMovies = [];
  final List<MovieResult> _upcomingMovies = [];
  final List<MovieResult> _topRatedMovies = [];

  MoviesApiResModel? _trendingMoviesApiResModel;
  MoviesApiResModel? _upcomingMoviesApiResModel;
  MoviesApiResModel? _popularMoviesApiResModel;

  final ScrollController _trendingScrollController = ScrollController();
  // pagination
  int _currentPage = 1;
  int? _totalPages;
  bool _isLoadingMore = false;
  // Upcoming pagination
  final ScrollController _upcomingScrollController = ScrollController();
  int _upcomingCurrentPage = 1;
  int? _upcomingTotalPages;
  bool _isLoadingMoreUpcoming = false;
  // Popular/TopRated pagination
  final ScrollController _popularScrollController = ScrollController();
  int _popularCurrentPage = 1;
  int? _popularTotalPages;
  bool _isLoadingMorePopular = false;

  // ------------------- [API Calls] ----------------

  Future<void> _refresh() async {
    setState(() {
      hasError = false;
      errorMessage = '';
      _future = _fetchAllMovies();
    });
  }

  Future<bool> _fetchAllMovies() async {
    try {
      // Load trending first (handles pagination state)
      await getTrendingMovies();

      // Fetch upcoming and popular in parallel
      final upcomingFuture = ApiFun.apiRequestHttpRawBody(
        ApiConstants.upcomingMovies,
        {'api_key': ApiConstants.apiKey, 'page': 1},
        method: ApiMethods.get,
      );

      final popularFuture = ApiFun.apiRequestHttpRawBody(
        ApiConstants.popularMovies,
        {'api_key': ApiConstants.apiKey, 'page': 1},
        method: ApiMethods.get,
      );

      final responses = await Future.wait([upcomingFuture, popularFuture]);

      final upcomingJson = responses[0];
      final popularJson = responses[1];

      if (upcomingJson != null && upcomingJson is Map<String, dynamic>) {
        _upcomingMoviesApiResModel = MoviesApiResModel.fromJson(upcomingJson);
        _upcomingMovies
          ..clear()
          ..addAll(_upcomingMoviesApiResModel?.results ?? []);
      }

      if (popularJson != null && popularJson is Map<String, dynamic>) {
        _popularMoviesApiResModel = MoviesApiResModel.fromJson(popularJson);
        _topRatedMovies
          ..clear()
          ..addAll(_popularMoviesApiResModel?.results ?? []);
      }

      setState(() {});
      return true;
    } catch (e) {
      debugPrint('$debuggerTagHome Error fetching movies: $e');
      hasError = true;
      errorMessage = 'Failed to load movies';
      return false;
    }
  }

  Future<MoviesApiResModel?> _fetchTrendingPage(int page) async {
    final body = {
      'api_key': ApiConstants.apiKey,
      'language': 'en-US',
      'page': page,
    };
    final response = await ApiFun.apiRequestHttpRawBody(
      ApiConstants.trendingMovies,
      body,
      method: ApiMethods.get,
    );
    if (response != null && response is Map<String, dynamic>) {
      return MoviesApiResModel.fromJson(response);
    }
    return null;
  }

  /// Load the first page (or refresh)
  Future<MoviesApiResModel?> getTrendingMovies() async {
    _currentPage = 1;
    final res = await _fetchTrendingPage(_currentPage);
    if (res != null) {
      setState(() {
        _trendingMoviesApiResModel = res;
        _trendingMovies
          ..clear()
          ..addAll(res.results ?? []);
        _totalPages = res.totalPages;
      });
    }
    return _trendingMoviesApiResModel;
  }

  /// Load next page and append results
  Future<void> _loadMoreTrending() async {
    if (_isLoadingMore) return;
    if (_totalPages != null && _currentPage >= _totalPages!) return;

    setState(() {
      _isLoadingMore = true;
      _currentPage += 1;
    });

    try {
      final next = await _fetchTrendingPage(_currentPage);
      if (next != null && next.results != null && next.results!.isNotEmpty) {
        setState(() {
          _trendingMoviesApiResModel?.results ??= <MovieResult>[];
          _trendingMoviesApiResModel?.results?.addAll(next.results!);
          _trendingMovies
            ..clear()
            ..addAll(_trendingMoviesApiResModel?.results ?? []);
          _totalPages = next.totalPages ?? _totalPages;
        });
      }
    } catch (e) {
      debugPrint('Error loading more trending movies: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<MoviesApiResModel?> _fetchUpcomingPage(int page) async {
    final body = {
      'api_key': ApiConstants.apiKey,
      'language': 'en-US',
      'page': page,
    };
    final response = await ApiFun.apiRequestHttpRawBody(
      ApiConstants.upcomingMovies,
      body,
      method: ApiMethods.get,
    );
    if (response != null && response is Map<String, dynamic>) {
      return MoviesApiResModel.fromJson(response);
    }
    return null;
  }

  Future<void> _loadMoreUpcoming() async {
    if (_isLoadingMoreUpcoming) return;
    if (_upcomingTotalPages != null &&
        _upcomingCurrentPage >= _upcomingTotalPages!) {
      return;
    }

    setState(() {
      _isLoadingMoreUpcoming = true;
      _upcomingCurrentPage += 1;
    });

    try {
      final next = await _fetchUpcomingPage(_upcomingCurrentPage);
      if (next != null && next.results != null && next.results!.isNotEmpty) {
        setState(() {
          _upcomingMoviesApiResModel?.results ??= <MovieResult>[];
          _upcomingMoviesApiResModel?.results?.addAll(next.results!);
          _upcomingMovies
            ..clear()
            ..addAll(_upcomingMoviesApiResModel?.results ?? []);
          _upcomingTotalPages = next.totalPages ?? _upcomingTotalPages;
        });
      }
    } catch (e) {
      debugPrint('Error loading more upcoming movies: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMoreUpcoming = false;
        });
      }
    }
  }

  Future<MoviesApiResModel?> _fetchPopularPage(int page) async {
    final body = {
      'api_key': ApiConstants.apiKey,
      'language': 'en-US',
      'page': page,
    };
    final response = await ApiFun.apiRequestHttpRawBody(
      ApiConstants.popularMovies,
      body,
      method: ApiMethods.get,
    );
    if (response != null && response is Map<String, dynamic>) {
      return MoviesApiResModel.fromJson(response);
    }
    return null;
  }

  Future<void> _loadMorePopular() async {
    if (_isLoadingMorePopular) return;
    if (_popularTotalPages != null &&
        _popularCurrentPage >= _popularTotalPages!) {
      return;
    }

    setState(() {
      _isLoadingMorePopular = true;
      _popularCurrentPage += 1;
    });

    try {
      final next = await _fetchPopularPage(_popularCurrentPage);
      if (next != null && next.results != null && next.results!.isNotEmpty) {
        setState(() {
          _popularMoviesApiResModel?.results ??= <MovieResult>[];
          _popularMoviesApiResModel?.results?.addAll(next.results!);
          _topRatedMovies
            ..clear()
            ..addAll(_popularMoviesApiResModel?.results ?? []);
          _popularTotalPages = next.totalPages ?? _popularTotalPages;
        });
      }
    } catch (e) {
      debugPrint('Error loading more popular movies: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMorePopular = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _future = _fetchAllMovies();
    _trendingScrollController.addListener(() {
      if (_trendingScrollController.position.maxScrollExtent > 0 &&
          _trendingScrollController.position.pixels >=
              _trendingScrollController.position.maxScrollExtent - 200) {
        if (!_isLoadingMore &&
            (_totalPages == null || _currentPage < (_totalPages ?? 0))) {
          _loadMoreTrending();
        }
      }
    });
    _upcomingScrollController.addListener(() {
      if (_upcomingScrollController.position.maxScrollExtent > 0 &&
          _upcomingScrollController.position.pixels >=
              _upcomingScrollController.position.maxScrollExtent - 200) {
        if (!_isLoadingMoreUpcoming &&
            (_upcomingTotalPages == null ||
                _upcomingCurrentPage < (_upcomingTotalPages ?? 0))) {
          _loadMoreUpcoming();
        }
      }
    });
    _popularScrollController.addListener(() {
      if (_popularScrollController.position.maxScrollExtent > 0 &&
          _popularScrollController.position.pixels >=
              _popularScrollController.position.maxScrollExtent - 200) {
        if (!_isLoadingMorePopular &&
            (_popularTotalPages == null ||
                _popularCurrentPage < (_popularTotalPages ?? 0))) {
          _loadMorePopular();
        }
      }
    });
  }

  @override
  void dispose() {
    _trendingScrollController.removeListener(() {});
    _upcomingScrollController.removeListener(() {});
    _popularScrollController.removeListener(() {});
    _trendingScrollController.dispose();
    _upcomingScrollController.dispose();
    _popularScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            if (_trendingMovies.isEmpty &&
                _upcomingMovies.isEmpty &&
                _topRatedMovies.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: showSimpleLoaderOverlay(),
                ),
              );
            }
          }

          if (hasError) {
            return NoDataFound(title: errorMessage, onRefresh: _refresh);
          }

          if (snapshot.hasError) {
            return NoDataFound(
              title: AppStringConstants.somethingWentWrong,
              onRefresh: _refresh,
            );
          }

          if (snapshot.connectionState == ConnectionState.done &&
              _trendingMovies.isEmpty &&
              _upcomingMovies.isEmpty &&
              _topRatedMovies.isEmpty) {
            return NoDataFound(
              title: AppStringConstants.noMoviesFound,
              subTitle: AppStringConstants.pleaseTryAgain,
              onRefresh: _refresh,
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: SafeArea(
              child: Padding(
                padding: Sizes.paddingAll16,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header ------------------------
                      FadeInDown(
                        child: HomeAppBar(
                          userName: "Sourashis",
                          imageUrl:
                              "https://avatars.githubusercontent.com/u/47134238?v=4",
                        ),
                      ),

                      ///--------------------------[Body]--------------------------

                      /// ---------------- [Trending Movies]----------------
                      const SizedBox(height: Sizes.dimen_24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FadeInLeft(
                            child: Text(
                              AppStringConstants.trendingMovies,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          FadeInRight(
                            child: InkWell(
                              onTap: () {
                                /*TODO : view all */
                              },
                              child: Text(
                                AppStringConstants.viewAll,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontSize: Sizes.bodySmallSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.dimen_12),
                      FadeInUp(
                        preferences: AnimationPreferences(
                          duration: Duration(seconds: 4),
                        ),
                        child: SizedBox(
                          height:
                              MoviesCard.cardHeight +
                              (MoviesCard.verticalPadding * 2),
                          child: ListView.builder(
                            controller: _trendingScrollController,
                            itemCount:
                                (_trendingMoviesApiResModel?.results?.length ??
                                    0) +
                                (_isLoadingMore ? 1 : 0),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final resultsLength =
                                  _trendingMoviesApiResModel?.results?.length ??
                                  0;
                              // show loader item at the end when loading more
                              if (index >= resultsLength) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: Sizes.dimen_24,
                                      height: Sizes.dimen_24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final movie =
                                  _trendingMoviesApiResModel?.results?[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: MoviesCard.verticalPadding,
                                ),
                                child: MoviesCard(
                                  onTap: () {
                                    openScreenWithTransition(
                                      context,
                                      PageTransitionType.fade,
                                      MovieDetailsScreen(
                                        movieId: movie?.id ?? 0,
                                      ),
                                    );
                                  },
                                  title: movie?.originalTitle ?? "Movie Title",
                                  rating: movie?.voteAverage ?? 0,
                                  imageUrl: movie?.posterPath != null
                                      ? "${ApiConstants.imageBaseUrl}${movie?.posterPath}"
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      /// ---------------- [Upcoming Movies]----------------
                      const SizedBox(height: Sizes.dimen_24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeInLeft(
                            child: Text(
                              AppStringConstants.upcomingMovies,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          FadeInRight(
                            child: InkWell(
                              onTap: () {
                                /*TODO : view all  */
                              },
                              child: Text(
                                AppStringConstants.viewAll,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontSize: Sizes.bodySmallSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.dimen_12),
                      FadeInUp(
                        preferences: AnimationPreferences(
                          duration: Duration(seconds: 3),
                        ),
                        child: SizedBox(
                          height:
                              MoviesCard.cardHeight +
                              (MoviesCard.verticalPadding * 2),
                          child: ListView.builder(
                            controller: _upcomingScrollController,
                            itemCount:
                                (_upcomingMovies.length) +
                                (_isLoadingMoreUpcoming ? 1 : 0),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index >= _upcomingMovies.length) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: Sizes.dimen_24,
                                      height: Sizes.dimen_24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: MoviesCard.verticalPadding,
                                ),
                                child: MoviesCard(
                                  onTap: () {
                                    openScreenWithTransition(
                                      context,
                                      PageTransitionType.fade,
                                      MovieDetailsScreen(
                                        movieId: _upcomingMovies[index].id ?? 0,
                                      ),
                                    );
                                  },
                                  title:
                                      _upcomingMovies[index].originalTitle ??
                                      _upcomingMovies[index].title,
                                  rating:
                                      _upcomingMovies[index].voteAverage ?? 0,
                                  imageUrl:
                                      _upcomingMovies[index].posterPath != null
                                      ? "${ApiConstants.imageBaseUrl}${_upcomingMovies[index].posterPath}"
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      /// ---------------- [Top Rated Movies]----------------
                      const SizedBox(height: Sizes.dimen_24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeInLeft(
                            child: Text(
                              AppStringConstants.topRatedMovies,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          FadeInRight(
                            child: InkWell(
                              onTap: () {
                                /*TODO : view all */
                              },
                              child: Text(
                                AppStringConstants.viewAll,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontSize: Sizes.bodySmallSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.dimen_12),
                      FadeInUp(
                        preferences: AnimationPreferences(
                          duration: Duration(seconds: 2),
                        ),
                        child: SizedBox(
                          height:
                              MoviesCard.cardHeight +
                              (MoviesCard.verticalPadding * 2),
                          child: ListView.builder(
                            controller: _popularScrollController,
                            itemCount:
                                (_topRatedMovies.length) +
                                (_isLoadingMorePopular ? 1 : 0),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index >= _topRatedMovies.length) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: Sizes.dimen_24,
                                      height: Sizes.dimen_24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: MoviesCard.verticalPadding,
                                ),
                                child: MoviesCard(
                                  onTap: () {
                                    openScreenWithTransition(
                                      context,
                                      PageTransitionType.fade,
                                      MovieDetailsScreen(
                                        movieId: _topRatedMovies[index].id ?? 0,
                                      ),
                                    );
                                  },
                                  title:
                                      _topRatedMovies[index].originalTitle ??
                                      _topRatedMovies[index].title,
                                  rating:
                                      _topRatedMovies[index].voteAverage ?? 0,
                                  imageUrl:
                                      _topRatedMovies[index].posterPath != null
                                      ? "${ApiConstants.imageBaseUrl}${_topRatedMovies[index].posterPath}"
                                      : null,
                                ),
                              );
                            },
                          ),
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
