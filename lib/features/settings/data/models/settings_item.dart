import 'package:flutter/material.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/theme/app_colors.dart';

class SettingsItem {
  final String? iconUrl;
  final String? title;
  final Color? color;
  final bool? isToggleWidget;

  SettingsItem({
    this.iconUrl,
    this.title,
    this.color,
    this.isToggleWidget,
  });

  static List<SettingsItem> getSettingsItems() {
    return [
      SettingsItem(
        iconUrl: AssetsManager.moon,
        title: "دارک مود",
        isToggleWidget: true,
      ),
      SettingsItem(
        iconUrl: AssetsManager.virusChecked,
        title: "حریم خصوصی",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: AssetsManager.virus,
        title: "گزارش باگ",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: AssetsManager.call,
        title: "تماس با ما",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: AssetsManager.information,
        title: "درباره ما",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: AssetsManager.exit,
        title: "خروج از حساب کاربری",
        color: AppColors.errorColor,
      ),
    ];
  }
}
