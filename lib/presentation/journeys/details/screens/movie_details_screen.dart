import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/genres.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/movies_card.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/widgets/Buttons/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:cinex_app/presentation/journeys/details/widgets/main_banner_image.dart';

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
              Stack(
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
              // -------------- [Movie Info Section] ----------------
              Padding(
                padding: Sizes.paddingAll16,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ------------ movie poster ------------
                        MoviesCard(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/s0Mlo5w4INp3bUdsJo3RaSSMXWz.jpg",
                        ),
                        // ------------ movie title and details ------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Movie Title",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            // ------------ movie rating ------------
                            Wrap(
                              children: [
                                Genres(genres: "Action"),
                                Genres(genres: "Action"),
                                Genres(genres: "Action"),
                                Genres(genres: "Action"),
                                Genres(genres: "Action"),
                                Genres(genres: "Action"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
