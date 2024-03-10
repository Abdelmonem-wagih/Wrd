// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Routes {
  static const String initialRoute = '/';
  static const String HomeWidget = '/homeWidget';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
        body: Center(
          child: Text('No Route Found'),
        ),
      )),
    );
  }
}

class RouteGenerator {
  static const String splash = '/';
  static const String HomeWidget = '/homeWidget';
  static const String locationPermission = '/location_permission';

  RouteGenerator._();

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case splash:
  //       return MaterialPageRoute(builder: (_) => const SplashScreen());
  //     case HomeWidget:
  //       return MaterialPageRoute(builder: (_) => const HomeWidget(ayaNumber: ayaNumber));
  //     case locationPermission:
  //       return MaterialPageRoute(
  //           builder: (_) => const LocationPermissionScreen());
  //
  //     default:
  //       throw RouteException('Route not found');
  //   }
  }

