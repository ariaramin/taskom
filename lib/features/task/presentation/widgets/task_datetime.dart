import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/section_title.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/extentions/timeofday_extention.dart';

class TaskDatetime extends StatefulWidget {
  final Jalali? currentDate;
  final TimeOfDay? currentTime;
  final Function(Jalali selectedDate) onDateChanged;
  final Function(TimeOfDay selectedTime) onTimeChanged;

  const TaskDatetime({
    super.key,
    this.currentDate,
    this.currentTime,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  State<TaskDatetime> createState() => _TaskDatetimeState();
}

class _TaskDatetimeState extends State<TaskDatetime> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  Jalali _selectedDate = Jalali.now();

  @override
  void initState() {
    if (widget.currentDate != null && widget.currentTime != null) {
      _selectedDate = widget.currentDate!;
      _selectedTime = widget.currentTime!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          const SectionTitle(
            title: "روز و ساعت تسک",
            visibleLeadingText: false,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Row(
              children: [
                AppChip(
                  title: _selectedDate.formatShortMonthDay(),
                  widget: SvgPicture.asset(
                    AssetsManager.calendar,
                    width: 18,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onTap: () async {
                    var picker = await showPersianDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: Jalali.now(),
                      lastDate: Jalali.now().addYears(1),
                    );
                    setState(() {
                      _selectedDate = picker!;
                    });
                    widget.onDateChanged(_selectedDate);
                  },
                ),
                const SizedBox(
                  width: 12,
                ),
                AppChip(
                  title: _selectedTime.getHourAndMinute(),
                  widget: SvgPicture.asset(
                    AssetsManager.time,
                    width: 18,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onTap: () async {
                    var picker = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      cancelText: "لغو",
                      confirmText: "تایید",
                      hourLabelText: "ساعت",
                      minuteLabelText: "دقیقه",
                      helpText: "انتخاب ساعت",
                      errorInvalidText: "زمان معتبر وارد کنید",
                    );
                    setState(() {
                      _selectedTime = picker!;
                    });
                    widget.onTimeChanged(_selectedTime);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
