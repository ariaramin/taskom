import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/components/cached_image.dart';

class AvatarItem extends StatelessWidget {
  final int currentIndex;
  final int selectedAvatarIndex;
  final String? imageUrl;

  const AvatarItem({
    super.key,
    required this.currentIndex,
    required this.selectedAvatarIndex,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(62),
        border: selectedAvatarIndex == currentIndex
            ? Border.all(
                width: 4,
                color: AppColors.primaryColor,
              )
            : null,
        color: AppColors.secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: CachedImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
