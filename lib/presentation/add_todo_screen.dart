import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:todo_valuechain/controller/add_todo_controlller.dart';

class AddTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: AddTodoForm(
        activeController: AddTodoController(),
      ),
    );
  }
}

class AddTodoForm extends ActiveView<AddTodoController> {
  const AddTodoForm({super.key, required super.activeController});

  @override
  ActiveState<ActiveView<ActiveController>, AddTodoController>
      createActivity() => _AddTodoFormState(activeController);
}

class _AddTodoFormState extends ActiveState<AddTodoForm, AddTodoController> {
  _AddTodoFormState(super.activeController);

  @override
  void initState() {
    super.initState();
  }

  Map<String, Map<String, dynamic>> formResults = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: activeController.taskNameController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: activeController.taskDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: activeController.taskPriorityController,
            decoration: const InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              activeController.addTask(context);
            },
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}

// class AddTodoForm extends StatefulWidget {
//   @override
//   _AddTodoFormState createState() => _AddTodoFormState();
// }
//
// class _AddTodoFormState extends State<AddTodoForm> {
//   final TextEditingController _taskNameController = TextEditingController();
//   final TextEditingController _taskDescriptionController =
//       TextEditingController();
//   final TextEditingController _taskPriorityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           TextField(
//             controller: _taskNameController,
//             decoration: const InputDecoration(
//               labelText: 'Title',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 12.0),
//           TextField(
//             controller: _taskDescriptionController,
//             decoration: InputDecoration(
//               labelText: 'Description',
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 3,
//           ),
//           SizedBox(height: 12.0),
//           TextField(
//             controller: _taskPriorityController,
//             decoration: InputDecoration(
//               labelText: 'Priority',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               _submitTodo();
//             },
//             child: Text('Add Todo'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _submitTodo() async {
//     String taskName = _taskNameController.text.trim();
//     String taskDescription = _taskDescriptionController.text.trim();
//     String priority = _taskPriorityController.text.trim();
//
//     if (taskName.isEmpty || taskDescription.isEmpty || priority.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill in all fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     Task newTask = Task(
//       taskName: taskName,
//       taskDescription: taskDescription,
//       taskPriority: priority,
//     );
//
//     await QuickeyDB.getInstance!<TaskSchema>()!.create(newTask);
//
//     Navigator.pop(context, newTask);
//   }
// }
