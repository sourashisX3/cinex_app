import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final VoidCallback onTap;
  const ThemeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: onTap,
      child: Container(
        height: Sizes.dimen_32,
        width: Sizes.dimen_32,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColor.white
              : AppColor.black,
          borderRadius: BorderRadius.circular(Sizes.dimen_16),
        ),
        child: Icon(
          Icons.dark_mode_rounded,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColor.black
              : AppColor.white,
        ),
      ),
    );
  }
}
