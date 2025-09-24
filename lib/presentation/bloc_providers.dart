import 'package:cinex_app/data/bloc/internet_connectivity_bloc/internet_bloc.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviderList {
  // Return a fresh list of providers each time to avoid reusing the same
  // provider instances across rebuilds which can lead to unexpected behavior.
  static List<BlocProvider> get providers => [
    BlocProvider<ThemeCubit>(create: (BuildContext context) => ThemeCubit()),
    BlocProvider<InternetBloc>(
      create: (BuildContext context) => InternetBloc(),
    ),
  ];
}
