import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForwardButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.dimen_25),
      child: Container(
        width: Sizes.dimen_50,
        height: Sizes.dimen_50,
        decoration: BoxDecoration(
          color: AppColor.primaryActionColor,
          borderRadius: BorderRadius.circular(Sizes.dimen_25),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_forward,
            color: AppColor.white,
            size: Sizes.iconSize,
          ),
        ),
      ),
    );
  }
}
