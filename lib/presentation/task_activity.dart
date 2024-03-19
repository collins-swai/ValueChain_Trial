import 'package:activity/core/active.dart';
import 'package:flutter/material.dart';
import 'package:todo_valuechain/controller/main_controller.dart';
import 'task_list_screen.dart';

class TaskActivity extends StatefulWidget {
  const TaskActivity({super.key});

  @override
  State<TaskActivity> createState() => _TaskActivityState();
}

class _TaskActivityState extends State<TaskActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: TaskListScreen(),
      body: TaskListScreen(),
    );
  }
}
