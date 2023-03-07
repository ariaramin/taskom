import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class AppChip extends StatelessWidget {
  final String title;
  final Widget? widget;
  final bool isLight;

  const AppChip({
    Key? key,
    required this.title,
    this.widget,
    this.isLight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: isLight ? AppColors.secondaryColor : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isLight ? AppColors.primaryColor : Colors.white,
                ),
              ),
              SizedBox(
                width: widget != null ? 8 : 0,
              ),
              widget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
