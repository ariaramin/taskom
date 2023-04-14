import 'package:flutter/material.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouteNames.search);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          top: 14,
          bottom: 28,
        ),
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
                    AssetsManager.search,
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
      ),
    );
  }
}
