import 'package:flutter/material.dart';
import 'package:taskom/config/components/custom_appbar.dart';
import 'package:taskom/config/components/task_list.dart';
import 'package:taskom/config/components/timeline_tabbar.dart';
import 'package:taskom/features/task/presentation/widgets/calendar_progress_bar.dart';
import 'package:taskom/features/task/presentation/widgets/date_picker.dart';
import 'package:taskom/features/task/presentation/widgets/date_section.dart';

class TaskListBody extends StatelessWidget {
  const TaskListBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomAppBar(
              rightSection: DateSection(),
              leftSection: CalendarAndProgressBar(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 18),
            sliver: SliverToBoxAdapter(
              child: DatePicker(
                startDate: DateTime.now(),
                endDate: DateTime.now().add(const Duration(days: 30)),
                initialSelectedDate: DateTime.now(),
                onSelectedDateChange: (date) {},
              ),
            ),
          ),
          // const SliverPadding(
          //   padding: EdgeInsets.only(bottom: 8),
          //   sliver: SliverToBoxAdapter(
          //     child: TimeLineTabBar(),
          //   ),
          // ),
          // const TaskList(),
        ],
      ),
    );
  }
}
