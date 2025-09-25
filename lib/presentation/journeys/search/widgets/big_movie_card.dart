import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:flutter/material.dart';

class BigMovieCard extends StatelessWidget {
  final String title;
  final String? posterPath; // /xxxx.jpg
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final String? overview;

  const BigMovieCard({
    super.key,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.overview,
  });

  String _buildImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    // Use w780 for backdrops and w500 for posters depending on path length isn't known here — keep w500 which is safe
    return 'https://image.tmdb.org/t/p/w500${path.startsWith('/') ? path : '/$path'}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = backdropPath != null && backdropPath!.isNotEmpty
        ? _buildImageUrl(backdropPath)
        : _buildImageUrl(posterPath);

    return Stack(
      children: [
        // Background image
        Container(
          width: getScreenWidth(context),
          height: Sizes.dimen_350,
          margin: const EdgeInsets.only(bottom: Sizes.dimen_16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.dimen_16),
            image: imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: const AssetImage('assets/images/app_logo.jpeg'),
                    fit: BoxFit.cover,
                  ),
          ),
        ),

        // Gradient overlay for readability
        Container(
          width: getScreenWidth(context),
          height: Sizes.dimen_350,
          margin: const EdgeInsets.only(bottom: Sizes.dimen_16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.dimen_16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.scaffoldBackgroundColor.withOpacity(0.05),
                theme.scaffoldBackgroundColor.withOpacity(0.85),
              ],
              stops: const [0.45, 1.0],
            ),
          ),
        ),

        // Top-right like / votes
        Positioned(
          top: Sizes.dimen_16,
          right: Sizes.dimen_16,
          child: Container(
            padding: EdgeInsets.all(Sizes.dimen_8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.dimen_30),
              color: theme.scaffoldBackgroundColor.withAlpha(180),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber.shade600,
                  size: Sizes.dimen_20,
                ),
                const SizedBox(width: 6),
                Text(
                  voteAverage != null ? voteAverage!.toStringAsFixed(1) : '—',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                Container(
                  height: Sizes.dimen_24,
                  width: 1,
                  color: theme.dividerColor.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.people,
                  size: Sizes.dimen_18,
                  color: theme.iconTheme.color?.withOpacity(0.8),
                ),
                const SizedBox(width: 6),
                Text(
                  voteCount != null ? voteCount.toString() : '0',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),

        // Bottom details: title, release date and overview
        Positioned(
          left: Sizes.dimen_16,
          right: Sizes.dimen_16,
          bottom: Sizes.dimen_16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  if (releaseDate != null && releaseDate!.isNotEmpty)
                    Text(releaseDate!, style: theme.textTheme.bodySmall),
                  const SizedBox(width: 10),
                  if (voteAverage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: Sizes.dimen_16,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            voteAverage!.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (overview != null && overview!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  overview!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.9),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
