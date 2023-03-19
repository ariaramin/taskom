import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class FormBottomText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function()? onTap;

  const FormBottomText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstText,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            secondText,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
