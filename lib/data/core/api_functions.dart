/* import 'dart:convert';
import 'package:cinex_app/data/core/api_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../common/utils/api_methods.dart';

class ApiFun {
  
  static Future<dynamic> apiRequestHttpRawBody(
      String endpoint, Map<String, dynamic> body,
      {String method = ApiMethods.post}) async {
    final isConnected = await checkInternetAndGoForward();
    if (isConnected) {
      try {
        var headers = {
          'Content-Type': 'application/json',
          // 'x-access-token': ApiConstants.accessToken,
          // 'x-access-token': HiveDatabase().getAccessToken(),
        };
        var request =
            http.Request(method, Uri.parse(ApiConstants.baseUrl + endpoint));
        request.body = json.encode(body);
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.toBytes();
        String responseString = String.fromCharCodes(responseData);
        final jsonData = jsonDecode(responseString);
        if (response.statusCode == 502) {
          RootApp.navigatorKey.currentState
              ?.pushReplacementNamed(RouteList.badGatewayScreen);
        }
        if (jsonData['message'] == AppMessages.unauthorizedTxt ||
            jsonData['status'] == 2) {
          debugPrint('---- Status code: ${response.statusCode}');
          RootApp.navigatorKey.currentState
              ?.pushReplacementNamed(RouteList.unauthorizedScreen);
        }
        debugPrint('$endpoint Api Res : $jsonData');
        return jsonData;
      } catch (e) {
        debugPrint("Api error in $endpoint: $e");
      }
    }
  }

   static Future<bool> checkInternetAndGoForward() async {
    final isInternetAvailable = await checkInternet();
    if (isInternetAvailable) {
      return true;
    } else {
      // TODO show internet not available message
      showInternetMessage(
          RootApp.navigatorKey.currentContext!, "Internet not available",
          isSlow: false);
    }
    return false;
  }

} */