import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/button_names.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForwardButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: onTap,
      child: Container(
        width: getScreenWidth(context),
        height: Sizes.dimen_50,
        decoration: BoxDecoration(
          color: AppColor.primaryActionColor,
          borderRadius: BorderRadius.circular(Sizes.dimen_25),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ButtonNames.getStarted,
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              const SizedBox(width: Sizes.dimen_8),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.white,
                size: Sizes.iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
