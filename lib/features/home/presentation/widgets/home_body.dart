import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/features/home/presentation/bloc/home_bloc.dart';
import 'package:taskom/features/home/presentation/bloc/home_event.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';
import 'package:taskom/features/home/presentation/widgets/category_list.dart';
import 'package:taskom/features/home/presentation/widgets/search_container.dart';
import 'package:taskom/features/home/presentation/widgets/section_title.dart';
import 'package:taskom/features/home/presentation/widgets/welcome_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeDataRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 8,
          child: CustomScrollView(
            slivers: [
              if (state is HomeLoadingState) ...{
                const SliverFillRemaining(
                  child: CircularProgressIndicator(),
                ),
              },
              if (state is HomeResponseState) ...{
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

                // category
                state.allCategories.fold((failure) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(failure.message)),
                  );
                }, (response) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 22),
                    sliver: SliverToBoxAdapter(
                      child: CategoryList(
                        categoryList: response,
                      ),
                    ),
                  );
                }),
                const SliverToBoxAdapter(
                  child: SectionTitle(
                    title: "تسک های امروز",
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: TimeLineTabBar(),
                  ),
                ),
                const TaskList(),
              }
            ],
          ),
        );
      },
    );
  }
}
