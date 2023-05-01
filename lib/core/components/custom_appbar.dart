import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leftSection;
  final Widget? rightSection;

  const CustomAppBar({
    Key? key,
    this.rightSection,
    this.leftSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          rightSection ?? const SizedBox(),
          leftSection ?? const SizedBox(),
        ],
      ),
    );
  }
}
