import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/features/home/presentation/widgets/category_list.dart';
import 'package:taskom/features/home/presentation/widgets/search_container.dart';
import 'package:taskom/features/home/presentation/widgets/section_title.dart';
import 'package:taskom/features/home/presentation/widgets/welcome_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: CustomScrollView(
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
          const SliverToBoxAdapter(
            child: SearchContainer(),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: "دسته‌بندی ها",
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 22),
            sliver: SliverToBoxAdapter(
              child: CategoryList(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: "تسک های امروز",
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
            ),
            sliver: SliverToBoxAdapter(
              child: TimeLineTabBar(),
            ),
          ),
          SliverFillRemaining(
            child: TaskList(),
          ),
        ],
      ),
    );
  }
}
