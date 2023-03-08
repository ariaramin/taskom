import 'package:flutter/material.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/config/theme/app_colors.dart';

class DateSection extends StatelessWidget {
  const DateSection({
    Key? key,
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
        const Text(
          "۲۰ تسک فعال برای امروز",
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
