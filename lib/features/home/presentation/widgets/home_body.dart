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
    return const DefaultTabController(
      length: 8,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
          SliverToBoxAdapter(
            child: SectionTitle(
              title: "دسته‌بندی ها",
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 22),
            sliver: SliverToBoxAdapter(
              child: CategoryList(),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionTitle(
              title: "تسک های امروز",
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 8,
            ),
            sliver: SliverToBoxAdapter(
              child: TimeLineTabBar(),
            ),
          ),
          TaskList(),
        ],
      ),
    );
  }
}
