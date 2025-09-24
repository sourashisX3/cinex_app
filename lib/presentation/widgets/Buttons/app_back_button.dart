import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/button_names.dart';
import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: Sizes.dimen_36,
        width: Sizes.dimen_75,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black87
              : Colors.white70,
          borderRadius: BorderRadius.circular(Sizes.dimen_12),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.dimen_4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: Sizes.iconSizeSmall,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                Text(
                  ButtonNames.back,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
