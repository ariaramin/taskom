import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/theme/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const BottomNavigation({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      items: [
        _bottomNavigationItem(
          label: "خانه",
          icon: AssetsManager.home,
          activeIcon: AssetsManager.homeBold,
        ),
        _bottomNavigationItem(
          label: "تسک ها",
          icon: AssetsManager.calendar,
          activeIcon: AssetsManager.calendarBold,
        ),
        _bottomNavigationItem(
          label: "تنظیمات",
          icon: AssetsManager.settings,
          activeIcon: AssetsManager.settingsBold,
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationItem({
    required String label,
    required String icon,
    required String activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          icon,
          color: AppColors.greyColor,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4),
        child: SvgPicture.asset(
          activeIcon,
          color: AppColors.primaryColor,
        ),
      ),
      label: label,
    );
  }
}
