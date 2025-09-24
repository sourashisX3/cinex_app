import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: onTap,
      child: Container(
        height: Sizes.dimen_60,
        width: getScreenWidth(context),
        decoration: BoxDecoration(
          color: AppColor.primaryActionColor,
          borderRadius: BorderRadius.circular(Sizes.dimen_12),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
