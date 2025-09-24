import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/common/constants/size_constants.dart';

class VotesSection extends StatelessWidget {
  final int votes;
  const VotesSection({super.key, required this.votes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_50.w,
      decoration: BoxDecoration(
        color: AppColor.primaryActionColor,
        borderRadius: BorderRadius.circular(Sizes.dimen_12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.dimen_4),
          child: Text(
            "$votes votes",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColor.white),
          ),
        ),
      ),
    );
  }
}
