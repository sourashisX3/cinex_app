import 'package:flutter/material.dart';
import 'package:cinex_app/common/constants/size_constants.dart';

class RatingSection extends StatelessWidget {
  final double? rating;

  const RatingSection({super.key, this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.dimen_6,
        vertical: Sizes.dimen_4,
      ),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: Sizes.dimen_4),
          Text(
            rating != null ? rating!.toStringAsFixed(1) : '--',
            style: const TextStyle(
              fontSize: Sizes.bodySmallSize,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
