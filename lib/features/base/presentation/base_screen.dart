import 'package:flutter/material.dart';
import 'package:taskom/features/base/presentation/widgets/bottom_navigation.dart';
import 'package:taskom/features/home/presentation/home_screen.dart';
import 'package:taskom/features/settings/presentation/settings_screen.dart';
import 'package:taskom/features/task/presentation/presenters/task_list_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   index: _selectedItem,
      //   children: _getScreens(),
      // ),
      body: _getScreens()[_selectedItem],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedItem,
        onTap: (value) {
          setState(() {
            _selectedItem = value;
          });
        },
      ),
    );
  }

  List<Widget> _getScreens() {
    return const [
      HomeScreen(),
      TaskListScreen(),
      SettingsScreen(),
    ];
  }
}
