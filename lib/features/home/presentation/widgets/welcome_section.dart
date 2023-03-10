import 'package:flutter/material.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/config/theme/app_colors.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ContinuousRectangle(
          size: 54,
          backgroundColor: AppColors.secondaryColor,
          widget: Image.asset("assets/images/avatar.png"),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  "سلام، ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "آریا",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              DateTime.now().getJalaliDayAndMonth(),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
