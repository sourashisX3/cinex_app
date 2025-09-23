import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/generated/assets.dart';
import 'package:cinex_app/presentation/journeys/nav/app_nav_bar.dart';
import 'package:cinex_app/presentation/journeys/onboardings/widgets/skip_button.dart';
import 'package:cinex_app/presentation/libraries/AppContents/FlutterPageTransition/src/enum.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:cinex_app/presentation/widgets/forward_button.dart';
import 'package:flutter/material.dart';

class ThirdOnboardinScreen extends StatelessWidget {
  const ThirdOnboardinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              height: getScreenHeight(context),
              width: getScreenWidth(context),
              child: Image.asset(Assets.imagesBomkesh, fit: BoxFit.cover),
            ),
            // Gradient Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Sizes.dimen_60.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(200)],
                  ),
                ),
              ),
            ),
            // Skip Button
            Positioned(
              top: Sizes.dimen_32,
              right: Sizes.dimen_16,
              child: SkipButton(
                onTap: () {
                  /*TODO */
                },
              ),
            ),
            // Text and Button
            Positioned(
              bottom: Sizes.dimen_50,
              left: Sizes.dimen_16,
              right: Sizes.dimen_16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStringConstants.onBoardingTitle2,
                    textAlign: TextAlign.center,
                    style: AppTheme.darkTheme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: Sizes.dimen_16),
                  ForwardButton(
                    onTap: () {
                      openScreenWithTransition(
                        context,
                        PageTransitionType.rightToLeft,
                        const AppNavBar(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
