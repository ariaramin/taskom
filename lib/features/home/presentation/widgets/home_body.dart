import 'package:flutter/material.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/home/presentation/bloc/home_bloc.dart';
import 'package:taskom/features/home/presentation/bloc/home_event.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';
import 'package:taskom/features/home/presentation/widgets/category_list.dart';
import 'package:taskom/features/home/presentation/widgets/home_appbar.dart';
import 'package:taskom/features/home/presentation/widgets/home_task_list.dart';
import 'package:taskom/features/home/presentation/widgets/search_container.dart';
import 'package:taskom/config/components/section_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/util/filter.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_event.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _activeTasksCount = 0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getTaskData("date ~ '${DateTime.now().getGregorianDate()}'");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getData();
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeResponseState) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HomeAppBar(activeTasksCount: _activeTasksCount),
                ),
                const SliverToBoxAdapter(
                  child: SearchContainer(),
                ),
                const SliverToBoxAdapter(
                  child: SectionTitle(title: "دسته‌بندی ها"),
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
                SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: TimeLineTabBar(
                      onSelectedTimeChange: (times) =>
                          _filterTasksByTime(times),
                    ),
                  ),
                ),
                HomeTaskList(
                  onResponseRetrieved: (response) {
                    setState(() {
                      _activeTasksCount = response.length;
                    });
                  },
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 76),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  _filterTasksByTime(List<DateTime>? times) {
    times != null
        ? _getTaskData("date >= '${times[0]}' && date <= '${times[1]}'")
        : _getTaskData("date ~ '${DateTime.now().getGregorianDate()}'");
  }

  _getData() {
    _getHomeData();
    _getUser();
    _getTaskData("date ~ '${DateTime.now().getGregorianDate()}'");
  }

  _getTaskData(String filter) {
    BlocProvider.of<TaskBloc>(context).add(
      TaskListRequestEvent(
        taskListParams: TaskListParams(
          filter: Filter(
            filterSequence: filter,
          ),
        ),
      ),
    );
  }

  _getUser() {
    BlocProvider.of<AuthBloc>(context).add(GetUserRequestEvent());
  }

  _getHomeData() {
    BlocProvider.of<HomeBloc>(context).add(HomeDataRequestEvent());
  }
}
