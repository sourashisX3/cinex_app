import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/button_names.dart';
import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.dimen_20),
          color: AppColor.black.withAlpha(250),
        ),
        height: Sizes.dimen_30,
        width: Sizes.dimen_80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ButtonNames.skipButton,
              style: AppTheme.darkTheme.textTheme.bodySmall,
            ),
            const SizedBox(width: Sizes.dimen_2),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.white,
              size: Sizes.iconSizeSmall,
            ),
          ],
        ),
      ),
    );
  }
}
