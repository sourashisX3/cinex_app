import 'dart:convert';
import 'package:cinex_app/common/constants/route_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/data/core/api_constants.dart';
import 'package:cinex_app/presentation/root_app.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../common/utils/api_methods.dart';

class ApiFun {
  static Future<dynamic> apiRequestHttpRawBody(
    String endpoint,
    Map<String, dynamic> body, {
    String method = ApiMethods.post,
  }) async {
    final isConnected = await checkInternetAndGoForward();
    if (isConnected) {
      try {
        var headers = {
          'Content-Type': 'application/json',
        };
        String joinBaseAndEndpoint(String base, String ep) {
          final baseHasSlash = base.endsWith('/');
          final epHasSlash = ep.startsWith('/');
          if (baseHasSlash && epHasSlash) return base + ep.substring(1);
          if (!baseHasSlash && !epHasSlash) return '$base/$ep';
          return base + ep;
        }
        if (method == ApiMethods.get) {
          Uri uri = Uri.parse(
            joinBaseAndEndpoint(ApiConstants.baseUrl, endpoint),
          );
          final mergedQuery = Map<String, String>.from(uri.queryParameters);
          body.forEach((key, value) {
            if (value != null) mergedQuery[key] = value.toString();
          });
          uri = uri.replace(queryParameters: mergedQuery);

          debugPrint('GET Request: $uri');
          final response = await http.get(uri, headers: headers);
          debugPrint('Response status: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');

          if (response.statusCode == 502) {
            RootApp.navigatorKey.currentState?.pushReplacementNamed(
              RouteList.badGatewayScreen,
            );
            return null;
          }

          if (response.body.trim().isEmpty) {
            debugPrint('Empty response body for $uri');
            return null;
          }

          dynamic jsonData;
          try {
            jsonData = jsonDecode(response.body);
          } catch (e) {
            debugPrint('Failed to decode JSON for $uri: $e');
            return null;
          }

          if (jsonData is Map &&
              (jsonData['message'] == AppStringConstants.unauthorizedTxt ||
                  jsonData['status'] == 2)) {
            debugPrint('---- Status code: ${response.statusCode}');
            RootApp.navigatorKey.currentState?.pushReplacementNamed(
              RouteList.unauthorizedScreen,
            );
          }

          debugPrint('$endpoint Api Res : $jsonData');
          return jsonData;
        }
        var request = http.Request(
          method,
          Uri.parse(joinBaseAndEndpoint(ApiConstants.baseUrl, endpoint)),
        );
        request.body = json.encode(body);
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.toBytes();
        String responseString = String.fromCharCodes(responseData);
        final jsonData = jsonDecode(responseString);
        if (response.statusCode == 502) {
          RootApp.navigatorKey.currentState?.pushReplacementNamed(
            RouteList.badGatewayScreen,
          );
        }
        if (jsonData['message'] == AppStringConstants.unauthorizedTxt ||
            jsonData['status'] == 2) {
          debugPrint('---- Status code: ${response.statusCode}');
          RootApp.navigatorKey.currentState?.pushReplacementNamed(
            RouteList.unauthorizedScreen,
          );
        }
        debugPrint('$endpoint Api Res : $jsonData');
        return jsonData;
      } catch (e) {
        debugPrint("Api error in $endpoint: $e");
        return null;
      }
    }
  }

  static Future<bool> checkInternetAndGoForward() async {
    final isInternetAvailable = await checkInternet();
    if (isInternetAvailable) {
      return true;
    } else {
      showInternetMessage(
        RootApp.navigatorKey.currentContext!,
        "Internet not available",
        isSlow: false,
      );
    }
    return false;
  }
}
