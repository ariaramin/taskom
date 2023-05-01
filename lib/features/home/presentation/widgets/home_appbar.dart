import 'package:flutter/material.dart';
import 'package:taskom/core/components/app_chip.dart';
import 'package:taskom/core/components/custom_appbar.dart';
import 'package:taskom/features/home/presentation/widgets/welcome_section.dart';

class HomeAppBar extends StatelessWidget {
  final int _activeTasksCount;

  const HomeAppBar({
    super.key,
    required int activeTasksCount,
  }) : _activeTasksCount = activeTasksCount;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      rightSection: const WelcomeSection(),
      leftSection: AppChip(
        title: "$_activeTasksCount تسک فعال",
        isLight: true,
      ),
    );
  }
}
