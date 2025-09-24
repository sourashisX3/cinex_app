import 'package:cinex_app/presentation/libraries/AppContents/TapAnimations/bouncy_tap_animation.dart';
import 'package:flutter/material.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';

class EditButton extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;

  const EditButton({super.key, required this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BouncyTapAnimation(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColor.primaryActionColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withAlpha(100),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.edit, size: 18, color: Colors.white),
      ),
    );
  }
}
