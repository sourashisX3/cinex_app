import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/presentation/journeys/details/screens/movie_details_screen.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/home_app_bar.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/movies_card.dart';
import 'package:cinex_app/presentation/libraries/AppContents/FlutterPageTransition/src/enum.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: MoviesCard.verticalPadding,
                          ),
                          child: MoviesCard(
                            onTap: () {
                              openScreenWithTransition(
                                context,
                                PageTransitionType.fade,
                                const MovieDetailsScreen(),
                              );
                            },
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500/s0Mlo5w4INp3bUdsJo3RaSSMXWz.jpg",
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
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: MoviesCard.verticalPadding,
                          ),
                          child: MoviesCard(
                            onTap: () {
                              openScreenWithTransition(
                                context,
                                PageTransitionType.fade,
                                const MovieDetailsScreen(),
                              );
                            },
                            /* imageUrl:
                                "https://image.tmdb.org/t/p/w500/s0Mlo5w4INp3bUdsJo3RaSSMXWz.jpg", */
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
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: MoviesCard.verticalPadding,
                          ),
                          child: MoviesCard(
                            onTap: () {
                              // openScreen(context, const MovieDetailsScreen());
                              openScreenWithTransition(
                                context,
                                PageTransitionType.fade,
                                const MovieDetailsScreen(),
                              );
                            },
                            title: "Inception: The IMAX Experience",
                            rating: 7.8,
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500/s0Mlo5w4INp3bUdsJo3RaSSMXWz.jpg",
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
  }
}
