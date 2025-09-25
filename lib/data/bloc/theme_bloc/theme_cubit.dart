import 'package:cinex_app/data/bloc/theme_bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' show Brightness;

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({bool followSystem = true})
    : _followSystem = followSystem,
      super(_initialState(followSystem));

  bool _followSystem;

  bool get followSystem => _followSystem;

  void toggleTheme() {
    if (_followSystem) {
      _followSystem = false;
    }

    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

  void setFollowSystem(bool follow) {
    _followSystem = follow;
    if (_followSystem) {
      updateFromSystem();
    }
  }

  void updateFromSystem() {
    try {
      final Brightness platformBrightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;

      if (platformBrightness == Brightness.dark) {
        if (state is! DarkThemeState) emit(DarkThemeState());
      } else {
        if (state is! LightThemeState) emit(LightThemeState());
      }
    } catch (e) {
      debugPrint('ThemeCubit.updateFromSystem failed: $e');
    }
  }

  static ThemeState _initialState(bool followSystem) {
    if (!followSystem) return LightThemeState();

    try {
      final Brightness platformBrightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return platformBrightness == Brightness.dark
          ? DarkThemeState()
          : LightThemeState();
    } catch (e) {
      debugPrint('ThemeCubit._initialState failed: $e');
      return LightThemeState();
    }
  }
}
