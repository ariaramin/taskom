import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';
import 'package:taskom/config/constants/assets_manager.dart';

class SettingsTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? trailingWidget;
  final Color? color;
  final Function()? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingWidget,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            ContinuousRectangle(
              size: 46,
              backgroundColor: color,
              widget: SizedBox(
                width: 20,
                child: icon,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: trailingWidget ??
                  SvgPicture.asset(
                    AssetsManager.leftArrow,
                    width: 10,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
