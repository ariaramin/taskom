import 'package:flutter/material.dart';
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

  static List<SettingsItem> getSettingsItem() {
    return [
      SettingsItem(
        iconUrl: "assets/icons/Moon.svg",
        title: "دارک مود",
        isToggleWidget: true,
      ),
      SettingsItem(
        iconUrl: "assets/icons/Virus-Checked.svg",
        title: "حریم خصوصی",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: "assets/icons/Call.svg",
        title: "تماس با ما",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: "assets/icons/Information.svg",
        title: "درباره ما",
        isToggleWidget: false,
      ),
      SettingsItem(
        iconUrl: "assets/icons/Exit.svg",
        title: "خروج از حساب کاربری",
        color: AppColors.errorColor,
      ),
    ];
  }
}
