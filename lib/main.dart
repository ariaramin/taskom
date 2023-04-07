import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskom/config/route/app_route.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_theme.dart';
import 'package:taskom/config/theme/theme_provider.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  runApp(Application());
}

class Application extends StatelessWidget {
  final ThemeProvider _themeProvider = locator.get();

  Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: (settings) => AppRoute.generate(settings),
            // initialRoute: AuthManager.isLogedIn()
            //     ? AppRouteNames.base
            //     : AppRouteNames.selectAvatar,
            initialRoute: AppRouteNames.register,
          );
        },
      ),
    );
  }
}
