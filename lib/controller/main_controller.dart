import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:todo_valuechain/models/TaskModel.dart';

class MainController extends ActiveController {
  GlobalKey globalKey = GlobalKey<FormState>();

  Memory memory = Memory.memory;
  ActiveString appTitle = ActiveString('Task Manager');
  ActiveInt appBarSize = ActiveInt(45);
  ActiveInt pageNumber = ActiveInt(1);
  ActiveInt pageSize = ActiveInt(2);
  ActiveBool dataLoaded = ActiveBool(false);

  ActiveType appBackgroundColor = ActiveType(Colors.white);

  ActiveList<ActiveModel<Task>> tasks = ActiveList([
    ActiveModel(Task(
      taskName: 'Work',
      taskDescription: 'Interview android developers',
      taskPriority: 'High',
    ))
  ]);

  Map schema = {};

  @override
  List<ActiveType> get activities {
    return [tasks];
  }

  ActiveMap<String, Map<String, dynamic>> formResults = ActiveMap({});
}
