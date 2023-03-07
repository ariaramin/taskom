import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: SvgPicture.asset(
                  "assets/icons/Search.svg",
                  color: AppColors.greyColor,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text(
                "جستجوی تسک مورد نظر...",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.greyColor,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
