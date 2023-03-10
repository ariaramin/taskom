import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';
import 'package:taskom/config/theme/app_colors.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ContinuousRectangle(
            size: 68,
            backgroundColor: AppColors.secondaryColor,
            widget: Image.asset("assets/images/avatar.png"),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "آریا رامین",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "@ariaramin",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.greyColor,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
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
