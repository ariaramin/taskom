import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool visibleLeadingText;
  final VoidCallback? leadingTextOnTap;

  const SectionTitle({
    Key? key,
    required this.title,
    this.visibleLeadingText = true,
    this.leadingTextOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(
            visible: visibleLeadingText,
            child: GestureDetector(
              onTap: leadingTextOnTap,
              child: const Text(
                "مشاهده بیشتر",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
