import 'package:cinex_app/common/constants/app_string_constants.dart';
import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/generated/assets.dart';
import 'package:cinex_app/presentation/libraries/AppContents/FlutterPageTransition/src/enum.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:cinex_app/presentation/widgets/forward_button.dart';
import 'package:flutter/material.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: getScreenHeight(context),
              width: getScreenWidth(context),
              child: Image.asset(Assets.imagesIronMan, fit: BoxFit.cover),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: getScreenHeight(context) * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(200)],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: Sizes.dimen_50,
              left: Sizes.dimen_16,
              right: Sizes.dimen_16,
              child: Column(
                children: [
                  Text(
                    AppStringConstants.onBoardingTitle1,
                    textAlign: TextAlign.center,
                    style: AppTheme.darkTheme.textTheme.bodyLarge,
                  ),
                  ForwardButton(
                    onTap: () {
                      openScreenWithTransition(
                        context,
                        PageTransitionType.rightToLeft,
                        const FirstOnboardingScreen(),
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
