import 'dart:convert';
import 'package:quickeydb/quickeydb.dart';

import '../models/TaskModel.dart';


class TaskSchema extends DataAccessObject<Task> {
  TaskSchema()
      : super(
    '''
          CREATE TABLE tasks (
             id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            task_name TEXT NOT NULL,
            task_description TEXT NOT NULL,
            task_priority TEXT NOT NULL,
            is_completed INTEGER DEFAULT "0" NOT NULL
          )
          ''',
    relations: [],
    converter: Converter(
      encode: (task) => Task.fromMap(task),
      decode: (task) => task!.toMap(),
      decodeTable: (task) => task!.toTableMap(),
    ),
  );
}


