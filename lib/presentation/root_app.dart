import 'package:cinex_app/presentation/bloc_providers.dart';
import 'package:cinex_app/presentation/journeys/onboardings/screens/first_onboarding_screen.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_cubit.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: BlocProviderList.providers,
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state is LightThemeState
                    ? AppTheme.lightTheme
                    : AppTheme.darkTheme,
                home: const FirstOnboardingScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
