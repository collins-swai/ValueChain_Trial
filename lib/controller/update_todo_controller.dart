import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickeydb/quickeydb.dart';
import 'package:todo_valuechain/controller/main_controller.dart';
import 'package:todo_valuechain/models/TaskModel.dart';

import '../database/TaskSchema.dart';

class UpdateTodoController extends MainController {
  late TextEditingController taskNameController = TextEditingController();
  late TextEditingController taskDescriptionController =
      TextEditingController();
  late TextEditingController PriorityController = TextEditingController();
  int? completed;

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

  UpdateTodoController() {
    initializeQuickeyDB();
  }


  Future<void> updateTask(BuildContext context, int? id) async {
    String taskName = taskNameController.text.trim();
    String taskDescription = taskDescriptionController.text.trim();
    String priority = PriorityController.text.trim();

    if (taskName.isEmpty || taskDescription.isEmpty || priority.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int isCompletedValue = completed ?? 0;

    Task updatedTask = Task(
      id: id,
      taskName: taskName,
      taskDescription: taskDescription,
      taskPriority: priority,
      isCompleted: isCompletedValue,
    );

    print("What do we have here?: $taskName");

    await QuickeyDB.getInstance!<TaskSchema>()!.update(updatedTask);

    Navigator.pop(context, updatedTask);
  }
}
