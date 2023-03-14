import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/util/filter.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';
import 'package:taskom/features/task/presentation/bloc/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_event.dart';
import 'package:taskom/features/task/presentation/bloc/task_state.dart';
import 'package:taskom/features/task/presentation/widgets/calendar_progress_bar.dart';
import 'package:taskom/features/task/presentation/widgets/date_picker.dart';
import 'package:taskom/features/task/presentation/widgets/date_section.dart';

class TaskListBody extends StatefulWidget {
  const TaskListBody({
    super.key,
  });

  @override
  State<TaskListBody> createState() => _TaskListBodyState();
}

class _TaskListBodyState extends State<TaskListBody> {
  final ValueNotifier<List<TaskModel>> _taskList =
      ValueNotifier<List<TaskModel>>([]);
  final ValueNotifier<List<DateTime>> _taskDateList =
      ValueNotifier<List<DateTime>>([]);
  List<TaskModel> _remoteData = [];

  @override
  void initState() {
    // _getData("date ~ '${DateTime.now().getGregorianDate()}'");
    _getData("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getData("");
      },
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              if (state is TaskLoadingState) ...{
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              },
              if (state is TaskListResponse) ...{
                const SliverToBoxAdapter(
                  child: CustomAppBar(
                    rightSection: DateSection(),
                    leftSection: CalendarAndProgressBar(),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 18),
                  sliver: SliverToBoxAdapter(
                    child: ValueListenableBuilder(
                      valueListenable: _taskDateList,
                      builder: (context, value, child) {
                        return DatePicker(
                          startDate: DateTime.now(),
                          endDate: DateTime.now().add(const Duration(days: 30)),
                          initialSelectedDate: DateTime.now(),
                          markedDates: value,
                          onSelectedDateChange: (date) {
                            _taskList.value = _getFilterTasksByDate(date);
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 8),
                  sliver: SliverToBoxAdapter(
                    child: TimeLineTabBar(
                      onSelectedTimeChange: (times) {
                        _taskList.value = _getFilterTasksByTime(times);
                      },
                    ),
                  ),
                ),
                state.taskList.fold((failure) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(failure.message)),
                  );
                }, (response) {
                  _setData(response);
                  return ValueListenableBuilder(
                    valueListenable: _taskList,
                    builder: (context, value, child) {
                      return response.isEmpty
                          ? const SliverToBoxAdapter(
                              child: Center(
                                child: Text(Constants.NO_TASK_MESSAGE),
                              ),
                            )
                          : TaskList(taskList: value);
                    },
                  );
                }),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 76),
                ),
              },
            ],
          );
        },
      ),
    );
  }

  _getFilterTasksByTime(List<DateTime>? times) {
    _taskList.value = _getFilterTasksByDate(DateTime.now());
    return times != null
        ? _taskList.value
            .where((element) =>
                element.dateTime!.removeUtc().isInRange(times[0], times[1]))
            .toList()
        : _taskList.value;
  }

  _getFilterTasksByDate(DateTime? date) {
    _taskList.value = _remoteData;
    return date != null
        ? _taskList.value
            .where((element) => element.dateTime!.removeUtc().isSameDate(date))
            .toList()
        : _taskList.value;
  }

  _setTasksDateList() {
    _taskDateList.value =
        _remoteData.map((element) => element.dateTime!.removeTime()).toList();
  }

  _setData(List<TaskModel> response) {
    _remoteData = response;
    _setTasksDateList();
    _taskList.value = _getFilterTasksByDate(DateTime.now());
  }

  _getData(String filter) {
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
}
