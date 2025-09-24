import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  final String genres;
  const Genres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.dimen_24,
      decoration: BoxDecoration(
        color: AppColor.primaryActionColor,
        borderRadius: BorderRadius.circular(Sizes.dimen_12),
      ),
      child: Text(
        genres,
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
