import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/core/constants/assets_manager.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
        bottom: 32,
        top: 18,
      ),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 24,
                  child: SvgPicture.asset(
                    AssetsManager.rightArrow,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 34),
            ],
          ),
        ),
      ),
    );
  }
}
