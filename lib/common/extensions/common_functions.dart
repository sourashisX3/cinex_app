import 'dart:io';
import 'package:cinex_app/presentation/libraries/AppContents/FlutterPageTransition/src/page_transition.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
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
Future<bool> checkInternet() async {
  late bool isConnectedToInternet;
  if (kIsWeb) {
    isConnectedToInternet = true;
  } else {
    // NOT running on the web! You can check for additional platforms here.
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty) {
        /* context.read<InternetBloc>().add(
              InternetGainedEvent()); */
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
}

void showInternetMessage(
  BuildContext context,
  String message, {
  required bool isSlow,
}) {
  final snackBar = SnackBar(
    content: Text(message, textAlign: TextAlign.left),
    backgroundColor: isSlow ? AppColor.primaryActionColor : Colors.red,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Formats a [DateTime] into a human friendly string with ordinal suffix.
/// Example: 25th Jan, 2025
String formatDateWithSuffix(DateTime date) {
  final day = date.day;

  // Special case for 11,12,13 -> always 'th'
  String suffix;
  if (day >= 11 && day <= 13) {
    suffix = 'th';
  } else {
    switch (day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final month = months[date.month - 1];
  final year = date.year;
  return '$day$suffix $month, $year';
}

/// Safe wrapper: accepts nullable [DateTime] or ISO date [String].
/// Returns empty string when input is null or invalid.
String formatDateWithSuffixFrom(dynamic input, {String emptyValue = ''}) {
  if (input == null) return emptyValue;

  DateTime? date;
  if (input is DateTime) {
    date = input;
  } else if (input is String) {
    date = DateTime.tryParse(input);
  }

  if (date == null) return emptyValue;
  return formatDateWithSuffix(date);
}
