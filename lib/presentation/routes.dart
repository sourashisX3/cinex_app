import 'package:cinex_app/common/constants/route_constants.dart';
import 'package:cinex_app/presentation/journeys/nav/app_nav_bar.dart';
import 'package:cinex_app/presentation/libraries/AppUtilScreens/UnauthenticatedScreen.dart';
import 'package:cinex_app/presentation/libraries/AppUtilScreens/badgateway_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteList.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SizedBox(),
          settings: RouteSettings(
            name: RouteList.initialRoute,
            arguments: setting.arguments,
          ),
        );

      case RouteList.appNavBar:
        debugPrint('----Creating BottomNavBar route');
        return MaterialPageRoute(
          builder: (_) => AppNavBar(),
          settings: RouteSettings(
            name: RouteList.appNavBar,
            arguments: setting.arguments,
          ),
        );

      case RouteList.unauthorizedScreen:
        return MaterialPageRoute(builder: (_) => UnauthenticatedScreen());
      case RouteList.badGatewayScreen:
        return MaterialPageRoute(builder: (_) => BadgatewayScreen());
      case RouteList.homeScreen:
        return MaterialPageRoute(
          builder: (_) => SizedBox(),
          settings: RouteSettings(
            name: RouteList.homeScreen,
            arguments: setting.arguments,
          ),
        );
      default:
        debugPrint(
          '----No matching route found for: ${setting.name}, showing UnauthenticatedScreen',
        );
        return MaterialPageRoute(builder: (_) => UnauthenticatedScreen());
    }
  }
}
