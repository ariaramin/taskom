import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/config/util/filter.dart';
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
  final ValueNotifier<List<DateTime>?> markedDateList = ValueNotifier([]);
  late DateTime _selectedDate;
  List<DateTime>? _selectedTimeRange;

  @override
  void initState() {
    _filterTasks(DateTime.now(), null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _filterTasks(DateTime.now(), null);
      },
      child: CustomScrollView(
        slivers: [
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskListResponse) {
                return state.taskList.fold((failure) {
                  return _getAppBar([]);
                }, (response) {
                  return _getAppBar(response);
                });
              }
              return _getAppBar([]);
            },
          ),
          _getDatePicker(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 8),
            sliver: SliverToBoxAdapter(
              child: TimeLineTabBar(
                onSelectedTimeChange: (times) {
                  setState(() {
                    _selectedTimeRange = times;
                  });
                  _filterTasks(_selectedDate, times);
                },
              ),
            ),
          ),
          _getTaskList(),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 76),
          ),
        ],
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
          _setMarkedDateList(state.dateList);
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

  Widget _getAppBar(List<TaskModel> response) {
    return SliverToBoxAdapter(
      child: CustomAppBar(
        rightSection: const DateSection(),
        leftSection: CalendarAndProgressBar(taskList: response),
      ),
    );
  }

  Widget _getDatePicker() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 18),
      sliver: SliverToBoxAdapter(
        child: ValueListenableBuilder(
          valueListenable: markedDateList,
          builder: (context, value, child) {
            return DatePicker(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 30)),
              initialSelectedDate: DateTime.now(),
              markedDates: value,
              onSelectedDateChange: (date) {
                setState(() {
                  _selectedDate = date!;
                });
                _filterTasks(date!, _selectedTimeRange);
              },
            );
          },
        ),
      ),
    );
  }

  _setMarkedDateList(List<DateTime>? dateList) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      markedDateList.value = dateList;
    });
  }

  _filterTasks(DateTime date, List<DateTime>? times) {
    var filter = "date ~ '${date.getGregorianDate()}'";
    if (times != null) {
      var startDateTime = times[0].changeDate(date);
      var endDateTime = times[1].changeDate(date);
      filter += " && date >= '$startDateTime' && date <= '$endDateTime'";
    }
    _getData(filter);
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
