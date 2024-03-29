import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/config/theme/theme_provider.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/settings/data/models/settings_item.dart';
import 'package:taskom/features/settings/presentation/widgets/settings_tile.dart';

class SettingsList extends StatelessWidget {
  final List<SettingsItem> settingsList;
  final ThemeProvider _themeProvider = locator.get();

  SettingsList({
    super.key,
    required this.settingsList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: settingsList.length,
        (context, index) {
          return SettingsTile(
            onTap: () {
              switch (settingsList[index].settingsItemEnum) {
                case SettingsItemEnum.logout:
                  AuthManager.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouteNames.login,
                    (route) => false,
                  );
                  break;
                default:
              }
            },
            icon: SvgPicture.asset(
              settingsList[index].iconUrl!,
              color: Colors.white,
            ),
            title: settingsList[index].title!,
            color: settingsList[index].color,
            trailingWidget: settingsList[index].settingsItemEnum ==
                    SettingsItemEnum.darkMode
                ? ChangeNotifierProvider.value(
                    value: _themeProvider,
                    child: Consumer<ThemeProvider>(
                      builder: (context, theme, child) {
                        return FlutterSwitch(
                          width: 58,
                          height: 29,
                          toggleSize: 22,
                          activeColor: AppColors.primaryColor,
                          inactiveColor: AppColors.greyColor,
                          value: theme.isDark,
                          onToggle: (value) {
                            theme.isDark = value;
                          },
                        );
                      },
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
