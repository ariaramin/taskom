import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/components/continuous_rectangle.dart';
import 'package:taskom/core/constants/assets_manager.dart';
import 'package:taskom/features/task/data/models/task.dart';

class CalendarAndProgressBar extends StatefulWidget {
  final List<TaskModel> taskList;

  const CalendarAndProgressBar({
    super.key,
    required this.taskList,
  });

  @override
  State<CalendarAndProgressBar> createState() => _CalendarAndProgressBarState();
}

class _CalendarAndProgressBarState extends State<CalendarAndProgressBar> {
  final ValueNotifier<double> valueNotifier = ValueNotifier(0);

  @override
  void didUpdateWidget(covariant CalendarAndProgressBar oldWidget) {
    _setProgressBarValue();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SimpleCircularProgressBar(
          valueNotifier: valueNotifier,
          size: 52,
          progressStrokeWidth: 8,
          backStrokeWidth: 8,
          progressColors: const [AppColors.primaryColor],
          backColor: AppColors.secondaryColor,
          mergeMode: true,
          animationDuration: 2,
          onGetText: (double value) {
            return Text(
              '٪${value.toInt()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        const SizedBox(
          width: 28,
        ),
        ContinuousRectangle(
          size: 58,
          widget: SvgPicture.asset(
            AssetsManager.calendar,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _setProgressBarValue() {
    var totalCount = widget.taskList.length;
    var items =
        widget.taskList.where((element) => element.isDone == true).toList();
    valueNotifier.value =
        totalCount != 0 ? (items.length / totalCount) * 100 : 0;
  }
}
