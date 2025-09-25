import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/constants/strings/debugger_tags.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/data/core/api_constants.dart';
import 'package:cinex_app/data/core/api_functions.dart';
import 'package:cinex_app/presentation/journeys/details/models/movie_details_api_res_model.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/app_star_ratings.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/genres.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/movies_card.dart';
import 'package:cinex_app/presentation/libraries/AppContents/ProgressLibs/LoaderOverlay.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:cinex_app/presentation/libraries/AppUtilScreens/no_data_found.dart';
import 'package:cinex_app/presentation/widgets/Buttons/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/main_banner_image.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/votes_section.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/movie_tagline_section.dart';

import '../../../../common/utils/api_methods.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool hasError = false;
  String errorMessage = '';
  late Future _future;
  MovieDetailsApiResModel? _movieDetails;

  Future<MovieDetailsApiResModel?> _fetchMovieDetails() async {
    try {
      final body = {'api_key': ApiConstants.apiKey, 'language': 'en-US'};
      final response = await ApiFun.apiRequestHttpRawBody(
        ApiConstants.movieDetails(widget.movieId),
        body,
        method: ApiMethods.get,
      );

      final res = MovieDetailsApiResModel.fromJson(response);
      return _movieDetails = res;
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.toString();
      });
      return null;
    }
  }

  Future<void> _refresh() async {
    setState(() {
      hasError = false;
      errorMessage = '';
      _future = _fetchMovieDetails();
    });
  }

  @override
  void initState() {
    super.initState();
    _future = _fetchMovieDetails();
    debugPrint("$debuggerTagMovieDetailsScreen Movie ID: ${widget.movieId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            if (widget.movieId == 0) {
              return NoDataFound(
                title: AppStringConstants.noMoviesFound,
                subTitle: AppStringConstants.pleaseTryAgain,
                onRefresh: _refresh,
              );
            }
            if (_movieDetails == null) {
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
          if (_movieDetails == null) {
            return NoDataFound(
              title: AppStringConstants.noMoviesFound,
              subTitle: AppStringConstants.pleaseTryAgain,
              onRefresh: _refresh,
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      child: Stack(
                        children: [
                          // -------------- [Main Banner Image] ----------------
                          MainBannerImage(
                            imageUrl: _movieDetails?.posterPath != null
                                ? "${ApiConstants.imageBaseUrl}${_movieDetails?.posterPath}"
                                : "",
                          ),
                          // -------------- [Back Button] ----------------
                          Positioned(
                            top: Sizes.dimen_24,
                            left: Sizes.dimen_16,
                            child: AppBackButton(),
                          ),
                        ],
                      ),
                    ),
                    // -------------- [Movie Info Section] ----------------
                    Padding(
                      padding: Sizes.paddingAll16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ------------ movie poster ------------
                              FadeInLeft(
                                child: MoviesCard(
                                  imageUrl:
                                      "${ApiConstants.imageBaseUrl}${_movieDetails?.backdropPath}",
                                  isRatingsVisible: false,
                                ),
                              ),
                              SizedBox(width: Sizes.dimen_16),
                              // ------------ movie title and details ------------
                              Expanded(
                                child: FadeInRight(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: Sizes.dimen_8,
                                        ),
                                        child: Text(
                                          _movieDetails?.title ?? "",
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: FontSizes.title,
                                              ),
                                        ),
                                      ),
                                      // ------------ movie rating ------------
                                      Row(
                                        children: [
                                          AppStarRatingBar(
                                            starSize: Sizes.iconSizeMedium,
                                            value:
                                                (_movieDetails?.voteAverage !=
                                                    null
                                                ? (_movieDetails!.voteAverage! /
                                                      2)
                                                : 0.0),
                                          ),
                                          Text(
                                            "  ${_movieDetails?.voteAverage != null ? (_movieDetails!.voteAverage! / 2).toStringAsFixed(1) : 0.0}/5",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      // ------------ movie release date ------------
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.dimen_8,
                                        ),
                                        child: Text(
                                          AppStringConstants.releasedOn(
                                            formatDateWithSuffix(
                                              DateTime.tryParse(
                                                    _movieDetails
                                                            ?.releaseDate ??
                                                        "",
                                                  ) ??
                                                  DateTime.now(),
                                            ),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontSize: FontSizes.bodySmall,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      // ------------ vote count ------------
                                      VotesSection(
                                        votes: _movieDetails?.voteCount ?? 0,
                                      ),
                                      // ------------ movie tagline ------------
                                      MovieTaglineSection(
                                        tagline: _movieDetails?.tagline ?? "",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ------------ movie genres ------------
                          FadeInUp(
                            preferences: AnimationPreferences(
                              duration: Duration(milliseconds: 1200),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.dimen_8,
                              ),
                              child: Text(AppStringConstants.genres),
                            ),
                          ),
                          FadeInUp(
                            preferences: AnimationPreferences(
                              duration: Duration(milliseconds: 1400),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: Sizes.dimen_8,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: Sizes.dimen_2,
                                  runSpacing: Sizes.dimen_8,
                                  alignment: WrapAlignment.start,
                                  children: (_movieDetails?.genres ?? [])
                                      .map(
                                        (genre) => Genres(
                                          genres:
                                              genre.name ??
                                              'No genres available',
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          // ------------ movie description ------------
                          FadeInUp(
                            preferences: AnimationPreferences(
                              duration: Duration(milliseconds: 1600),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.dimen_8,
                              ),
                              child: Text(AppStringConstants.overview),
                            ),
                          ),
                          FadeInUp(
                            preferences: AnimationPreferences(
                              duration: Duration(milliseconds: 1800),
                            ),
                            child: Text(
                              _movieDetails?.overview ??
                                  " No overview available ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),

                          const SizedBox(height: Sizes.dimen_30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
