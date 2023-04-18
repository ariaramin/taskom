import 'package:flutter/material.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/features/authentication/presentation/presenters/login_screen.dart';
import 'package:taskom/features/authentication/presentation/presenters/register_screen.dart';
import 'package:taskom/features/authentication/presentation/presenters/select_avatar_screen.dart';
import 'package:taskom/features/base/presentation/base_screen.dart';
import 'package:taskom/features/search/presentation/search_screen.dart';
import 'package:taskom/features/task/presentation/presenters/task_screen.dart';

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
      case AppRouteNames.login:
        return MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: LoginScreen(),
          ),
          settings: settings,
        );
      case AppRouteNames.register:
        return MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: RegisterScreen(),
          ),
          settings: settings,
        );
      case AppRouteNames.selectAvatar:
        return MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: SelectAvatarScreen(),
          ),
          settings: settings,
        );
      case AppRouteNames.search:
        return MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: SearchScreen(),
          ),
          settings: settings,
        );
      case AppRouteNames.editTask:
        return MaterialPageRoute(
          builder: (context) => const Directionality(
            textDirection: TextDirection.rtl,
            child: TaskScreen(),
          ),
          settings: settings,
        );
    }
  }
}
