import 'dart:async';
import 'package:cinex_app/common/extensions/connectivity_wrapper.dart';
import 'package:cinex_app/data/data_sources/hive/data_sources_hive_database.dart';
import 'package:cinex_app/data/di/dependency_init.dart';
import 'package:cinex_app/presentation/journeys/auth/screens/login_screen.dart';
import 'package:cinex_app/presentation/libraries/AppContents/RedScreen/FlutterPhoenix/flutter_phoenix.dart';
import 'package:cinex_app/presentation/root_app.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  unawaited(
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: AppColor.transparent),
  );
  await Firebase.initializeApp();
  initDependencies();
  await HiveDatabase.initializeHive();
  runApp(Phoenix(child: RootApp(screenName: getUserById())));
}

Widget getUserById() {
  return const LoginScreen();
}
