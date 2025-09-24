import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/app_star_ratings.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/genres.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/movies_card.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/widgets/fading_entrances/fade_in_left.dart';
import 'package:cinex_app/presentation/widgets/Buttons/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/main_banner_image.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/votes_section.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/movie_tagline_section.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500/s0Mlo5w4INp3bUdsJo3RaSSMXWz.jpg",
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
                                "https://image.tmdb.org/t/p/w500/s0Mlo5w4INp3bUdsJo3RaSSMXWz.jpg",
                            isRatingsVisible: false,
                          ),
                        ),
                        SizedBox(width: Sizes.dimen_16),
                        // ------------ movie title and details ------------
                        Expanded(
                          child: FadeInRight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: Sizes.dimen_8,
                                  ),
                                  child: Text(
                                    "Movie Title - Movie Title",
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: FontSizes.title),
                                  ),
                                ),
                                // ------------ movie rating ------------
                                Row(
                                  children: [
                                    AppStarRatingBar(
                                      starSize: Sizes.iconSizeMedium,
                                      value: 4.5,
                                    ),
                                    Text(
                                      "  4.5/5",
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
                                      "25th Jan, 2025",
                                    ),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          fontSize: FontSizes.bodySmall,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                // ------------ vote count ------------
                                const VotesSection(votes: 2500),
                                // ------------ movie tagline ------------
                                const MovieTaglineSection(
                                  tagline:
                                      "This is the movie tagline, it is usually a catchy phrase that summarizes the movie.",
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
                        padding: const EdgeInsets.only(bottom: Sizes.dimen_8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: Sizes.dimen_2,
                            runSpacing: Sizes.dimen_8,
                            alignment: WrapAlignment.start,
                            children: const [
                              Genres(genres: "Action"),
                              Genres(genres: "Horror"),
                              Genres(genres: "Comedy"),
                              Genres(genres: "Action"),
                              Genres(genres: "Action"),
                              Genres(genres: "Action"),
                            ],
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
                        "The Demon Slayer Corps are drawn into the Infinity Castle, where Tanjiro, Nezuko, and the Hashira face terrifying Upper Rank demons in a desperate fight as the final battle against Muzan Kibutsuji begins.",
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
  }
}
