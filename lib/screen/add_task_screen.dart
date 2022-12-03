import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskom/constants/constants.dart';
import 'package:taskom/utility/utility.dart';
import 'package:taskom/widgets/task_type_widget.dart';

import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _subtitleTextController = TextEditingController();
  var _isTitleEmpty = false;
  var _isSubtitleEmpty = false;

  var taskBox = Hive.box<Task>("tasks");
  TimeOfDay _time = TimeOfDay(hour: 10, minute: 0);
  int _selectedTaskType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                _getTextFields(context),
                SizedBox(
                  height: 18,
                ),
                _getTimePickerButton(context),
                SizedBox(
                  height: 18,
                ),
                _getTaskTypeList(),
              ],
            ),
            Container(
              width: double.infinity,
              height: 46,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextButton(
                onPressed: () {
                  var taskTitle = _titleTextController.text;
                  var taskSubTitle = _subtitleTextController.text;
                  if (_isTextFieldsNotEmpty()) {
                    _addTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: primaryColor,
                  foregroundColor: whiteColor,
                  textStyle: TextStyle(
                    fontFamily: 'Shabnam',
                    fontSize: 16,
                  ),
                ),
                child: Text(
                  'اضافه کردن تسک',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTaskTypeList() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "نوع تسک",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 198,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getTaskTypeList().length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTaskType = index;
                  });
                },
                child: TaskTypeWidget(
                  taskType: getTaskTypeList()[index],
                  index: index,
                  selectedItem: _selectedTaskType,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getTimePickerButton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: 24,
            left: 24,
            bottom: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "ساعت تسک",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              showPicker(
                context: context,
                value: _time,
                cancelText: "بیخیال",
                cancelStyle: TextStyle(
                  fontFamily: "Shabnam",
                  color: Colors.red,
                ),
                is24HrFormat: true,
                okText: "انتخاب",
                okStyle: TextStyle(
                  fontFamily: "Shabnam",
                  color: greenColor,
                ),
                onChange: (TimeOfDay timeOfDay) {
                  setState(() {
                    _time = timeOfDay;
                  });
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 92,
                  height: 34,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${convertToPersianNumber(_time.hour)}:${_getMinute(_time)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: whiteColor,
                        ),
                      ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      Icon(
                        Iconsax.clock,
                        size: 24,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getMinute(TimeOfDay time) {
    return time.minute < 10
        ? '۰${convertToPersianNumber(time.minute)}'
        : convertToPersianNumber(time.minute);
  }

  Widget _getTextFields(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: blackColor.withOpacity(.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: blackColor,
                  ),
                ),
                labelText: "عنوان تسک",
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red.withOpacity(.7),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                errorText: _isTitleEmpty ? "این فیلد نباید خالی باشد" : null,
                floatingLabelStyle: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            TextField(
              controller: _subtitleTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: blackColor.withOpacity(.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: blackColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red.withOpacity(.7),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                errorText: _isSubtitleEmpty ? "این فیلد نباید خالی باشد" : null,
                labelText: "توضیحات",
                floatingLabelStyle: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isTextFieldsNotEmpty() {
    if (_titleTextController.text.isEmpty) {
      setState(() {
        _isTitleEmpty = true;
      });
      return false;
    }
    if (_subtitleTextController.text.isEmpty) {
      setState(() {
        _isSubtitleEmpty = true;
      });
      return false;
    }
    return true;
  }

  _addTask(String taskTitle, String taskSubtitle) {
    var task = Task(
      title: taskTitle,
      subTitle: taskSubtitle,
      time: _time,
      taskType: getTaskTypeList()[_selectedTaskType],
    );
    taskBox.add(task);
  }
}
