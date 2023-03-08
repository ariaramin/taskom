import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/features/task/presentation/widgets/date_picker_item.dart';

class DatePicker extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? initialSelectedDate;
  final Function(DateTime? date) onSelectedDateChange;

  const DatePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    this.initialSelectedDate,
    required this.onSelectedDateChange,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late AutoScrollController _scrollController;
  late ValueNotifier<DateTime?> _selectedDateValueNotifier;

  @override
  void initState() {
    _scrollController = AutoScrollController(axis: Axis.horizontal);
    _selectedDateValueNotifier =
        ValueNotifier<DateTime?>(widget.initialSelectedDate);
    if (widget.initialSelectedDate != null) {
      _scrollToInitialFocusedDate();
    }
    super.initState();
  }

  @override
  void dispose() {
    _selectedDateValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 118,
      child: ValueListenableBuilder(
        valueListenable: _selectedDateValueNotifier,
        builder: (context, selectedDate, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: widget.endDate.dateDifference(widget.startDate) + 1,
            itemBuilder: (context, index) {
              DateTime itemDate = widget.startDate.add(Duration(days: index));
              return AutoScrollTag(
                key: ValueKey(index),
                controller: _scrollController,
                index: index,
                child: DatePickerItem(
                  date: itemDate,
                  isActive: _isDatePickerItemSelected(itemDate, selectedDate),
                  onPressed: !_isDatePickerItemSelected(itemDate, selectedDate)
                      ? () {
                          _setSelectedDate(itemDate);
                          _scrollToIndex(index);
                        }
                      : () {},
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool _isDatePickerItemSelected(DateTime itemDate, DateTime? selectedDate) {
    if (selectedDate == null) return false;
    return itemDate.dateDifference(selectedDate) == 0;
  }

  _setSelectedDate(DateTime? date) {
    _selectedDateValueNotifier.value = date;
    widget.onSelectedDateChange(date);
  }

  _scrollToIndex(index) async {
    await _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  _scrollToInitialFocusedDate() async {
    _scrollToIndex(
        widget.initialSelectedDate?.dateDifference(widget.startDate));
  }
}
