import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/extentions/datetime_extention.dart';

class DateSection extends StatelessWidget {
  final int activeTasksCount;

  const DateSection({
    Key? key,
    required this.activeTasksCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateTime.now().getJalaliDayAndMonth(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "$activeTasksCount تسک فعال برای امروز",
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
