import 'dart:io';

import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:todo_valuechain/controller/main_controller.dart';
import 'package:todo_valuechain/database/TaskSchema.dart';
import 'package:todo_valuechain/models/TaskModel.dart';
import 'package:quickeydb/quickeydb.dart';
import 'package:quickeydb/quickeydb.dart';

class AddTodoController extends MainController {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController taskPriorityController = TextEditingController();

  static void initializeQuickeyDB() async {
    await QuickeyDB.initialize(
      dbName: "QuickeyDB.db",
      persist: true,
      dbVersion: 4,
      dbPath: Directory.current.path,
      dataAccessObjects: [
        TaskSchema(),
      ],
    );
  }

  AddTodoController() {
    initializeQuickeyDB();
  }

  Future<void> addTask(BuildContext context) async {
    String taskName = taskNameController.text.trim();
    String taskDescription = taskDescriptionController.text.trim();
    String priority = taskPriorityController.text.trim();

    if (taskName.isEmpty || taskDescription.isEmpty || priority.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Task newTask = Task(
      taskName: taskName,
      taskDescription: taskDescription,
      taskPriority: priority,
    );

    print(newTask.taskName);

    await QuickeyDB.getInstance!<TaskSchema>()!.create(newTask);

    Navigator.pop(context, newTask);
  }

  @override
  List<ActiveType> get activities {
    return [];
  }
}
