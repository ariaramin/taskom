import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskom/constants/constants.dart';
import 'package:taskom/utility/utility.dart';
import 'package:taskom/widgets/task_type_widget.dart';

import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  Task task;
  EditTaskScreen(this.task, {super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController? _titleTextController;
  TextEditingController? _subtitleTextController;
  var _isTitleEmpty = false;
  var _isSubtitleEmpty = false;
  TimeOfDay? _time;
  int _selectedTaskType = 0;

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController(text: widget.task.title);
    _subtitleTextController = TextEditingController(text: widget.task.subTitle);

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
    _time = widget.task.time;
    _selectedTaskType = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      resizeToAvoidBottomInset: false,
      appBar: _getAppBar(),
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
            _getButton(context),
          ],
        ),
      ),
    );
  }

  Widget _getButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: TextButton(
        onPressed: () {
          var taskTitle = _titleTextController!.text;
          var taskSubTitle = _subtitleTextController!.text;
          if (_isTextFieldsNotEmpty()) {
            _editTask(taskTitle, taskSubTitle);
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
          '???????????? ????',
          style: TextStyle(
            fontSize: 14,
          ),
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
                "?????? ??????",
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
                "???????? ??????",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time!,
                      cancelText: "????????????",
                      cancelStyle: TextStyle(
                        fontFamily: "Shabnam",
                        color: Colors.red,
                      ),
                      is24HrFormat: true,
                      okText: "????????????",
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
                child: Container(
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
                        "${convertToPersianNumber(_time!.hour)}:${_getMinute(_time!)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: whiteColor,
                        ),
                      ),
                      Icon(
                        Iconsax.clock,
                        size: 24,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getMinute(TimeOfDay time) {
    return time.minute < 10
        ? '??${convertToPersianNumber(time.minute)}'
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
                labelText: "?????????? ??????",
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
                errorText: _isTitleEmpty ? "?????? ???????? ?????????? ???????? ????????" : null,
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
                errorText: _isSubtitleEmpty ? "?????? ???????? ?????????? ???????? ????????" : null,
                labelText: "??????????????",
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
    if (_titleTextController!.text.isEmpty) {
      setState(() {
        _isTitleEmpty = true;
      });
      return false;
    }
    if (_subtitleTextController!.text.isEmpty) {
      setState(() {
        _isSubtitleEmpty = true;
      });
      return false;
    }
    return true;
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      title: Text("???????????? ???????? ??????"),
      centerTitle: true,
    );
  }

  _editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskType];
    widget.task.save();
  }
}
