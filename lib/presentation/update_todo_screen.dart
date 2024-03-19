import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:quickeydb/quickeydb.dart';

import '../database/TaskSchema.dart';
import '../models/TaskModel.dart';



class UpdateTodoScreen extends StatefulWidget {
  final Task? task;

  const UpdateTodoScreen({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateTodoScreenState createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  late TextEditingController _taskNameController;
  late TextEditingController _taskDescriptionController;
  late TextEditingController _priorityController;
   int? completed;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController(text: widget.task!.taskName);
    _taskDescriptionController =
        TextEditingController(text: widget.task!.taskDescription);
    _priorityController = TextEditingController(text: widget.task!.taskPriority);
    completed = widget.task!.isCompleted!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _taskDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _priorityController,
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitUpdate(context);
              },
              child: const Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitUpdate(BuildContext context) async {
    String taskName = _taskNameController.text.trim();
    String taskDescription = _taskDescriptionController.text.trim();
    String priority = _priorityController.text.trim();

    if (taskName.isEmpty || taskDescription.isEmpty || priority.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Task updatedTask = Task(
      id:widget.task!.id,
      taskName: taskName,
      taskDescription: taskDescription,
      taskPriority: priority,
      isCompleted: completed,
    );

    await QuickeyDB.getInstance!<TaskSchema>()!.update(updatedTask);


    Navigator.pop(context, updatedTask);
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }
}
