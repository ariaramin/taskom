import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: AppColors.secondaryColor,
            image: const DecorationImage(
              image: AssetImage("assets/images/avatar.png"),
              alignment: Alignment.center,
            ),
          ),
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
            const Text(
              "۱۶ اسفند",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.greyColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}
