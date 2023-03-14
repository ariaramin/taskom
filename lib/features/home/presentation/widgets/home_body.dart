import 'package:flutter/foundation.dart';
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
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/util/filter.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ValueNotifier<List<TaskModel>> _taskList =
      ValueNotifier<List<TaskModel>>([]);
  List<TaskModel> _remoteData = [];

  @override
  void initState() {
    _getHomeData("date ~ '${DateTime.now().getGregorianDate()}'");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getHomeData("date ~ '${DateTime.now().getGregorianDate()}'");
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              if (state is HomeLoadingState) ...{
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
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
                SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 8,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: TimeLineTabBar(
                      onSelectedTimeChange: (times) {
                        _taskList.value = _getFilterTasks(times);
                      },
                    ),
                  ),
                ),

                state.allTasks.fold((failure) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(failure.message)),
                  );
                }, (response) {
                  _remoteData = response;
                  _taskList.value = response;
                  return ValueListenableBuilder(
                    valueListenable: _taskList,
                    builder: (context, value, child) {
                      return response.isEmpty
                          ? const SliverToBoxAdapter(
                              child: Center(
                                child: Text(Constants.NO_TASK_MESSAGE),
                              ),
                            )
                          : TaskList(
                              taskList: value,
                            );
                    },
                  );
                }),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 76),
                ),
              }
            ],
          );
        },
      ),
    );
  }

  _getFilterTasks(List<DateTime>? times) {
    _taskList.value = _remoteData;
    return times != null
        ? _taskList.value
            .where((element) =>
                element.dateTime!.removeUtc().isInRange(times[0], times[1]))
            .toList()
        : _taskList.value;
  }

  _getHomeData(String filter) {
    BlocProvider.of<HomeBloc>(context).add(
      HomeDataRequestEvent(
        taskListParams: TaskListParams(
          filter: Filter(
            filterSequence: filter,
          ),
        ),
      ),
    );
  }
}
