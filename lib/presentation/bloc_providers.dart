import 'package:cinex_app/data/bloc/internet_connectivity_bloc/internet_bloc.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_cubit.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_cubit.dart';
import 'package:cinex_app/presentation/journeys/auth/domain/repo/firebase_auth_repo.dart';
import 'package:cinex_app/presentation/journeys/profile/bloc/profile_cubit.dart';
import 'package:cinex_app/presentation/journeys/profile/domain/repo/firebase_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviderList {
  static List<BlocProvider> providers = [
    BlocProvider<ThemeCubit>(create: (BuildContext context) => ThemeCubit()),
    BlocProvider<InternetBloc>(
      create: (BuildContext context) => InternetBloc(),
    ),
    BlocProvider<AuthCubit>(
      create: (BuildContext context) =>
          AuthCubit(authRepo: FirebaseAuthRepo())..checkAuth(),
    ),
    BlocProvider<ProfileCubit>(
      create: (BuildContext context) =>
          ProfileCubit(profileRepo: FirebaseProfileRepo()),
    ),
  ];
}
