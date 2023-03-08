import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:taskom/config/theme/app_colors.dart';

class CalendarAndProgressBar extends StatefulWidget {
  const CalendarAndProgressBar({
    super.key,
  });

  @override
  State<CalendarAndProgressBar> createState() => _CalendarAndProgressBarState();
}

class _CalendarAndProgressBarState extends State<CalendarAndProgressBar> {
  final ValueNotifier<double> valueNotifier = ValueNotifier(30);

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
          animationDuration: 3,
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
        Container(
          height: 56,
          width: 56,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/Calendar.svg",
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
