// navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/views/pomodoro_timer_page.dart';
import 'dashboard.dart';
import 'settings_page.dart'; // Import the settings page

class Navigation_Bar extends StatelessWidget {
  const Navigation_Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TaskTrove"),
          backgroundColor: orangeColor,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
              Tab(icon: Icon(Icons.timeline), text: 'Pomodoro'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Dashboard(), // Dashboard tab
            PomodoroTimerPage(), // Pomodoro tab
            SettingsPage(), // Settings tab
          ],
        ),
      ),
    );
  }
}
