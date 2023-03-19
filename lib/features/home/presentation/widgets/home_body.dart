import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/features/home/presentation/bloc/home_bloc.dart';
import 'package:taskom/features/home/presentation/bloc/home_event.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';
import 'package:taskom/features/home/presentation/widgets/category_list.dart';
import 'package:taskom/features/home/presentation/widgets/search_container.dart';
import 'package:taskom/features/home/presentation/widgets/section_title.dart';
import 'package:taskom/features/home/presentation/widgets/welcome_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/util/filter.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';
import 'package:taskom/features/task/presentation/bloc/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_event.dart';
import 'package:taskom/features/task/presentation/bloc/task_state.dart';

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
    _getHomeData();
    _getTaskData("date ~ '${DateTime.now().getGregorianDate()}'");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getHomeData();
        _getTaskData("date ~ '${DateTime.now().getGregorianDate()}'");
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
                _getTaskList(),
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

  Widget _getTaskList() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is TaskListResponse) {
          return state.taskList.fold((failure) {
            return SliverToBoxAdapter(
              child: Center(child: Text(failure.message)),
            );
          }, (response) {
            return response.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Text(Constants.NO_TASK_MESSAGE),
                    ),
                  )
                : TaskList(taskList: response);
          });
        }
        return const SliverToBoxAdapter(
          child: SizedBox(),
        );
      },
    );
  }

  _filterTasksByTime(List<DateTime>? times) {
    times != null
        ? _getTaskData("date >= '${times[0]}' && date <= '${times[1]}'")
        : _getTaskData("date ~ '${DateTime.now().getGregorianDate()}'");
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

  _getHomeData() {
    BlocProvider.of<HomeBloc>(context).add(HomeDataRequestEvent());
  }
}
