import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';

class SettingsTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? trailingWidget;
  final Color? color;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingWidget,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ContinuousRectangle(
            size: 48,
            backgroundColor: color,
            widget: SizedBox(
              width: 24,
              child: icon,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: trailingWidget ??
                SvgPicture.asset(
                  "assets/icons/LeftArrow.svg",
                  width: 10,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ],
      ),
    );
  }
}