import 'package:flutter/material.dart';
import 'package:cinex_app/common/constants/size_constants.dart';

class MovieTaglineSection extends StatelessWidget {
  final String tagline;
  const MovieTaglineSection({super.key, required this.tagline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.dimen_8),
      child: Text(
        tagline,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontStyle: FontStyle.italic,
          fontSize: FontSizes.small,
        ),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
