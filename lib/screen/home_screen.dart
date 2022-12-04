import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskom/constants/constants.dart';
import 'package:taskom/models/task.dart';
import 'package:taskom/screen/add_task_screen.dart';
import 'package:taskom/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _taskBox = Hive.box<Task>("tasks");
  List<Task>? _taskList;
  ValueListenable<Box<Task>>? _valueListenable;
  bool _isSearchListEmpty = false;
  String? _searchValue;
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();
    _taskList = _taskBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: _getAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _taskBox.listenable(),
              builder: (context, value, child) {
                return Visibility(
                  visible: !_isSearchListEmpty && _taskBox.values.isEmpty,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 76),
                    child: Image.asset("images/completed.png"),
                  ),
                );
              },
            ),
            Visibility(
              visible: _isSearchListEmpty,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 76),
                    child: Image.asset("images/not_found.png"),
                  ),
                  Text(
                    "!تسک مورد نظر یافت نشد",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _taskBox.listenable(),
              builder: (context, value, child) {
                return Visibility(
                  visible: !_isSearchListEmpty && _taskBox.values.isNotEmpty,
                  // visible: true,
                  child: Expanded(
                    child: _getTaskList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: _getFAB(context),
    );
  }

  Widget _getTaskList() {
    return ValueListenableBuilder(
      valueListenable: _taskBox.listenable(),
      builder: (context, value, child) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            setState(() {
              if (notification.direction == ScrollDirection.forward) {
                _isFabVisible = true;
              } else if (notification.direction == ScrollDirection.reverse) {
                _isFabVisible = false;
              }
            });
            return true;
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: _searchValue == "" || _searchValue == null
                  ? _taskBox.values.toList().length
                  : _taskList!.length,
              itemBuilder: (context, index) {
                var task = _searchValue == "" || _searchValue == null
                    ? _taskBox.values.toList()[index]
                    : _taskList![index];
                return _getListItem(task);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task),
    );
  }

  Widget _getFAB(BuildContext context) {
    var duration = Duration(milliseconds: 300);
    return AnimatedSlide(
      duration: duration,
      offset: _isFabVisible ? Offset.zero : Offset(0, 2),
      child: AnimatedOpacity(
        duration: duration,
        opacity: _isFabVisible ? 1 : 0,
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          child: Icon(
            Iconsax.add,
            size: 28,
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      title: Text("تسکام"),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(82),
        child: _getSearchBox(context),
      ),
    );
  }

  Widget _getSearchBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 22,
        bottom: 14,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            color: whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Iconsax.search_normal_1),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      _search(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'جستجوی تسک...',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search(String value) {
    setState(() {
      _searchValue = value;
    });

    List<Task> searchedList = [];
    searchedList = _taskBox.values.toList().where((element) {
      return element.title.toLowerCase().contains(value.toLowerCase()) ||
          element.subTitle.toLowerCase().contains(value.toLowerCase());
    }).toList();

    setState(() {
      _taskList = searchedList;
      searchedList.isEmpty
          ? _isSearchListEmpty = true
          : _isSearchListEmpty = false;
    });
  }
}
