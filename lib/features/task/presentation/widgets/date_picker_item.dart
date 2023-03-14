import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';

class DatePickerItem extends StatelessWidget {
  final DateTime date;
  final bool isActive;
  final bool? isMarked;
  final VoidCallback onPressed;

  const DatePickerItem({
    super.key,
    required this.date,
    this.isActive = false,
    this.isMarked = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 32,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 74,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            color: isActive ? AppColors.primaryColor : AppColors.secondaryColor,
            shadows: isActive
                ? [
                    const BoxShadow(
                      color: AppColors.primaryColor,
                      blurRadius: 25,
                      spreadRadius: -12,
                      offset: Offset(0, 16),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  date.getJalaliWeekDay(),
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? Colors.white : AppColors.primaryColor,
                  ),
                ),
                Text(
                  date.getJalaliDay(),
                  style: TextStyle(
                    fontSize: 18,
                    color: isActive ? Colors.white : AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isMarked!
                    ? SizedBox(
                        width: 6,
                        height: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: isActive
                                ? Colors.white
                                : AppColors.primaryColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
