import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class ContinuousRectangle extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Widget widget;

  const ContinuousRectangle({
    super.key,
    required this.size,
    this.backgroundColor,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        color: backgroundColor ?? AppColors.primaryColor,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(child: widget),
      ),
    );
  }
}
