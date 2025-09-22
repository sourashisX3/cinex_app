import 'package:cinex_app/presentation/journeys/onboardings/screens/first_onboarding_screen.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const FirstOnboardingScreen(),
    );
  }
}
