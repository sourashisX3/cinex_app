import 'dart:io';

import 'package:cinex_app/data/bloc/internet_connectivity_bloc/internet_bloc.dart';
import 'package:cinex_app/data/bloc/internet_connectivity_bloc/internet_event.dart';
import 'package:cinex_app/presentation/libraries/AppContents/FlutterPageTransition/src/page_transition.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getScreenNotificationBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  Size getScreenBodySize(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double bodySize = mediaQuery.size.height + mediaQuery.padding.top + 65;
    //debugPrint('----screenWidth - bodySize : $screenWidth - $bodySize');
    return Size(screenWidth, bodySize);
  }

  void openScreen(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  Future<bool> openScreenWithBackValue(
    BuildContext context,
    Widget widget,
  ) async {
    try {
      return await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    } catch (e) {
      return false;
    }
  }

  void openScreenWithoutBack(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  void openScreenWithTransition(
    BuildContext context,
    pageTransitionType,
    Widget widget,
  ) {
    Navigator.push(
      context,
      PageTransition(
        type: pageTransitionType,
        alignment: Alignment.bottomCenter,
        child: widget,
      ),
    );
  }

  ////------  Block use here -------
/* Future<bool> checkInternet() async {
  late bool isConnectedToInternet;
  if (kIsWeb) {
    isConnectedToInternet = true;
  } else {
    // NOT running on the web! You can check for additional platforms here.
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty) {
        context.read<InternetBloc>().add(
              InternetGainedEvent());
        if (kDebugMode) {
          debugPrint('---- Internet  connected');
        }
        isConnectedToInternet = true;
      }
    } on SocketException catch (_) {
      isConnectedToInternet = false;
      if (kDebugMode) {
        debugPrint('---- Internet  Not connected');
      }
    }
  }
  return isConnectedToInternet;
} */
