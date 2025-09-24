import 'package:flutter/material.dart';

class AppStarRatingBar extends StatelessWidget {
  final double value;
  final int starCount;
  final double starSize;
  final Color filledColor;
  final Color unfilledColor;
  final Color halfFilledColor;

  const AppStarRatingBar({
    super.key,
    required this.value,
    this.starCount = 5,
    this.starSize = 24,
    this.filledColor = Colors.amber,
    this.unfilledColor = const Color(0xFFE0E0E0),
    this.halfFilledColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedValue = value.clamp(0, starCount).toDouble();
    final int fullStars = clampedValue.floor();
    final bool hasHalfStar =
        (clampedValue - fullStars) >= 0.25 && (clampedValue - fullStars) < 0.75;
    final int emptyStars = starCount - fullStars - (hasHalfStar ? 1 : 0);

    List<Widget> stars = [];
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: filledColor, size: starSize));
    }
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: halfFilledColor, size: starSize));
    }
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: unfilledColor, size: starSize));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
