import 'package:flutter/material.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/features/base/presentation/base_screen.dart';

class AppRoute {
  static generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.base:
        return MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: BaseScreen(),
          ),
          settings: settings,
        );
    }
  }
}
