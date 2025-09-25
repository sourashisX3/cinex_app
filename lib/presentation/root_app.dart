import 'package:cinex_app/common/constants/route_constants.dart';
import 'package:cinex_app/common/extensions/connectivity_wrapper.dart';
import 'package:cinex_app/data/data_sources/hive/data_sources_hive_database.dart';
import 'package:cinex_app/presentation/bloc_providers.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_cubit.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_states.dart';
import 'package:cinex_app/presentation/libraries/AppContents/RedScreen/red_screen.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:cinex_app/presentation/routes.dart';
import 'package:cinex_app/presentation/journeys/auth/screens/auth_screen.dart';
import 'package:cinex_app/presentation/themes/app_theme.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_cubit.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinex_app/presentation/journeys/profile/bloc/profile_cubit.dart';

class RootApp extends StatefulWidget {
  final Widget screenName;
  const RootApp({super.key, required this.screenName});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  void initState() {
    super.initState();
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return const RedScreen();
    };
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    HiveDatabase.box.close();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: BlocProviderList.providers,
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeState is LightThemeState
                    ? AppTheme.lightTheme
                    : AppTheme.darkTheme,
                navigatorKey: RootApp.navigatorKey,
                initialRoute: RouteList.initialRoute,
                onGenerateRoute: Routes.onGenerateRoute,
                home: BlocConsumer<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    if (authState is Unauthenticated) {
                      return const AuthScreen();
                    } else if (authState is Authenticated) {
                      final user = authState.user;
                      try {
                        context.read<ProfileCubit>().fetchUserProfile(user.uid);
                      } catch (_) {}
                      return const ConnectivityWrapper();
                    } else if (authState is AuthLoading ||
                        authState is AuthInitial) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    } else if (authState is AuthError) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  },
                  listener: (context, authState) {
                    if (authState is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authState.message)),
                      );
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
