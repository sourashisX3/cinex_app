import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'rating_section.dart';

class MoviesCard extends StatelessWidget {
  static final double cardWidth = Sizes.dimen_160;
  static final double cardHeight = Sizes.dimen_220;
  static const double verticalPadding = Sizes.dimen_8;
  final String? imageUrl;
  final String? title;
  final double? rating;
  final VoidCallback? onTap;
  final bool isRatingsVisible;

  const MoviesCard({
    super.key,
    this.imageUrl,
    this.title,
    this.rating,
    this.onTap,
    this.isRatingsVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: onTap,
      child: Card(
        elevation: Sizes.dimen_6,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.dimen_12),
        ),
        child: SizedBox(
          width: MoviesCard.cardWidth,
          height: MoviesCard.cardHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: Sizes.dimen_2,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColor.white
                          : AppColor.black,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white12
                        : Colors.black12,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white24
                          : Colors.black26,
                    ),
                  ),
                ),

                // Bottom faded black overlay with title and rating
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: Sizes.dimen_70,
                    padding: const EdgeInsets.all(Sizes.dimen_8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                          Colors.black87,
                        ],
                      ),
                    ),
                    child: isRatingsVisible
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  title ?? 'Unknown Title',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: Sizes.dimen_8),
                              RatingSection(rating: rating),
                            ],
                          )
                        : const SizedBox.shrink(),
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
