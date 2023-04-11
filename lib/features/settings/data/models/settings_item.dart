import 'package:flutter/material.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/theme/app_colors.dart';

class SettingsItem {
  final String? iconUrl;
  final String? title;
  final Color? color;
  final SettingsItemEnum settingsItemEnum;

  SettingsItem({
    this.iconUrl,
    this.title,
    this.color,
    required this.settingsItemEnum,
  });

  static List<SettingsItem> getSettingsItems() {
    return [
      SettingsItem(
        iconUrl: AssetsManager.moon,
        title: "دارک مود",
        settingsItemEnum: SettingsItemEnum.darkMode,
      ),
      SettingsItem(
        iconUrl: AssetsManager.virusChecked,
        title: "حریم خصوصی",
        settingsItemEnum: SettingsItemEnum.privacyPolicy,
      ),
      SettingsItem(
        iconUrl: AssetsManager.virus,
        title: "گزارش باگ",
        settingsItemEnum: SettingsItemEnum.reportBug,
      ),
      SettingsItem(
        iconUrl: AssetsManager.call,
        title: "تماس با ما",
        settingsItemEnum: SettingsItemEnum.contact,
      ),
      SettingsItem(
        iconUrl: AssetsManager.information,
        title: "درباره ما",
        settingsItemEnum: SettingsItemEnum.about,
      ),
      SettingsItem(
        iconUrl: AssetsManager.exit,
        title: "خروج از حساب کاربری",
        color: AppColors.errorColor,
        settingsItemEnum: SettingsItemEnum.logout,
      ),
    ];
  }
}

enum SettingsItemEnum {
  darkMode,
  privacyPolicy,
  reportBug,
  contact,
  about,
  logout,
}
