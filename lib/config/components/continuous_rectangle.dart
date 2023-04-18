import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class ContinuousRectangle extends StatelessWidget {
  final double size;
  final double radius;
  final Color? backgroundColor;
  final bool hasShadow;
  final Widget widget;

  const ContinuousRectangle({
    super.key,
    required this.size,
    this.radius = 48,
    this.backgroundColor,
    this.hasShadow = false,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: backgroundColor ?? AppColors.primaryColor,
        shadows: hasShadow
            ? [
                BoxShadow(
                  color: backgroundColor ?? AppColors.primaryColor,
                  blurRadius: 25,
                  spreadRadius: -12,
                  offset: const Offset(0.0, 15),
                )
              ]
            : null,
      ),
      child: Center(child: widget),
    );
  }
}
