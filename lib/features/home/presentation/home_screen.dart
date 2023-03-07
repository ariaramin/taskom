import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/home/presentation/widgets/search_container.dart';
import 'package:taskom/features/home/presentation/widgets/welcome_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomAppBar(
              rightSection: WelcomeSection(),
              leftSection: AppChip(
                title: "۲۰ تسک فعال",
                isLight: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SearchContainer(),
          ),
        ],
      ),
    );
  }
}
