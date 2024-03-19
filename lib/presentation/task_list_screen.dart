import 'package:activity/activity.dart';
import 'package:flutter/material.dart';
import 'package:quickeydb/quickeydb.dart';
import 'package:todo_valuechain/controller/add_todo_controlller.dart';
import 'package:todo_valuechain/controller/update_todo_controller.dart';
import 'package:todo_valuechain/database/TaskSchema.dart';
import 'package:todo_valuechain/presentation/add_todo_screen.dart';

import 'package:todo_valuechain/presentation/update_todo_screen.dart';

import '../models/TaskModel.dart';

class TaskListScreen extends ActiveView<AddTodoController> {
  const TaskListScreen({super.key, required super.activeController});

  @override
  ActiveState<ActiveView<ActiveController>, AddTodoController>
      createActivity() => _TaskListScreenState(activeController);
}

class _TaskListScreenState
    extends ActiveState<TaskListScreen, AddTodoController> {
  _TaskListScreenState(super.activeController);

  String? _searchQuery;
  List<Task?> allTasks = [];

  List<Task?> filtered = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activeController.appTitle.value),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List>(
            future: QuickeyDB.getInstance!<TaskSchema>()?.toList(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search tasks...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            filtered.clear();
                            setState(() {
                              _searchQuery = value.toLowerCase();
                              final results = snapshot.data!.where((element) {
                                final title = element.taskName.toLowerCase();
                                final description =
                                    element.taskDescription.toLowerCase();
                                final priority =
                                    element.taskPriority.toLowerCase();

                                return title.contains(_searchQuery) ||
                                    description.contains(_searchQuery) ||
                                    priority.contains(_searchQuery);
                              }).toList();
                              filtered.addAll(results as Iterable<Task?>);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _searchQuery == null
                            ? snapshot.data!.length
                            : filtered.length,
                        itemBuilder: (context, index) {
                          // final task = snapshot.data![index];
                          final task = _searchQuery == null
                              ? snapshot.data![index]
                              : filtered[index];

                          bool completed = task.isCompleted == 1 ? true : false;
                          return GestureDetector(
                            onTap: () async {
                              final updatedTask = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateTodoScreen(
                                    task: task,
                                    activeController: UpdateTodoController(),
                                  ),
                                ),
                              );
                              if (updatedTask != null) {
                                activeController.state.isTrue;
                                setState(() {
                                  activeController.state.isTrue;
                                });
                                Future.delayed(const Duration(seconds: 1), () {
                                  activeController.state.isFalse;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Task updated successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                });
                              }
                            },
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  snapshot.data!.remove(task);
                                });

                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                        'Delete ${task.taskName == null ? '' : task!.taskName}'),
                                    content: const Text(
                                        'Are you sure you want to delete this task?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                          deleteTask(task);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                activeController.state.isTrue;
                              },
                              child: Card(
                                elevation: 2.0,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                    task.taskName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(task.taskDescription),
                                      const SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Text(
                                            'Priority: ${task.taskPriority}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  trailing: Checkbox(
                                    value: completed,
                                    onChanged: (value) {
                                      final val;
                                      if (value == true) {
                                        val = 1;
                                      } else {
                                        val = 0;
                                      }
                                      final tasks = Task(
                                        id: task.id,
                                        taskName: task.taskName,
                                        taskDescription: task.taskDescription,
                                        taskPriority: task.taskPriority,
                                      );
                                      QuickeyDB.getInstance!<TaskSchema>()!
                                          .update(tasks..isCompleted = val);
                                      setState(() {});
                                      // Update task completion status
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Task status is completed'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );

          if (newTask != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task added successfully'),
                backgroundColor: Colors.green,
              ),
            );
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> deleteTask(task) async {
    await QuickeyDB.getInstance!<TaskSchema>()!.delete(task);
    // Simulate deletion with a delay

    Future.delayed(const Duration(seconds: 1), () {
      activeController.state.isFalse;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {});
    });
  }
}

// class TaskListScreen extends StatefulWidget {
//   @override
//   _TaskListScreenState createState() => _TaskListScreenState();
// }
//
// class _TaskListScreenState extends State<TaskListScreen> {
//   String? _searchQuery;
//   List<Task?> allTasks = [];
//
//   List<Task?> filtered = [];
//
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Manager'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: FutureBuilder<List>(
//             future: QuickeyDB.getInstance!<TaskSchema>()?.toList(),
//             builder: (BuildContext context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: TextField(
//                           decoration: const InputDecoration(
//                             hintText: 'Search tasks...',
//                             prefixIcon: Icon(Icons.search, color: Colors.grey),
//                             border: InputBorder.none,
//                           ),
//                           onChanged: (value) {
//                             filtered.clear();
//                             setState(() {
//                               _searchQuery = value.toLowerCase();
//                               final results = snapshot.data!.where((element) {
//                                 final title = element.taskName.toLowerCase();
//                                 final description =
//                                 element.taskDescription.toLowerCase();
//                                 final priority =
//                                 element.taskPriority.toLowerCase();
//
//                                 return title.contains(_searchQuery) ||
//                                     description.contains(_searchQuery) ||
//                                     priority.contains(_searchQuery);
//                               }).toList();
//                               filtered.addAll(results as Iterable<Task?>);
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: _searchQuery == null
//                             ? snapshot.data!.length
//                             : filtered.length,
//                         itemBuilder: (context, index) {
//                           // final task = snapshot.data![index];
//                           final task = _searchQuery == null
//                               ? snapshot.data![index]
//                               : filtered[index];
//
//                           bool completed = task.isCompleted == 1 ? true : false;
//                           return GestureDetector(
//                             onTap: () async {
//                               final updatedTask = await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       UpdateTodoScreen(
//                                         task: task,
//                                         activeController: UpdateTodoController(),
//                                       ),
//                                 ),
//                               );
//                               if (updatedTask != null) {
//                                 setState(() {
//                                   _isLoading = true;
//                                 });
//                                 Future.delayed(const Duration(seconds: 1), () {
//                                   setState(() {
//                                     _isLoading = false;
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content:
//                                       Text('Task updated successfully'),
//                                       backgroundColor: Colors.green,
//                                     ),
//                                   );
//                                 });
//                               }
//                             },
//                             child: Dismissible(
//                               key: UniqueKey(),
//                               // key: Key(task!.id.toString()),
//                               direction: DismissDirection.endToStart,
//                               background: Container(
//                                 color: Colors.red,
//                                 alignment: Alignment.centerRight,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20.0),
//                                 child: const Icon(
//                                   Icons.delete,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               onDismissed: (direction) {
//                                 setState(() {
//                                   snapshot.data!.remove(task);
//                                 });
//
//                                 showDialog<String>(
//                                   context: context,
//                                   builder: (BuildContext context) =>
//                                       AlertDialog(
//                                         title: Text(
//                                             'Delete ${task.taskName == null
//                                                 ? ''
//                                                 : task!.taskName}'),
//                                         content: const Text(
//                                             'Are you sure you want to delete this task?'),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.pop(
//                                                     context, 'Cancel'),
//                                             child: const Text('Cancel'),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.pop(context, 'OK');
//                                               deleteTask(task);
//                                             },
//                                             child: const Text('OK'),
//                                           ),
//                                         ],
//                                       ),
//                                 );
//                                 setState(() {
//                                   _isLoading = true; // Show loading indicator
//                                 });
//                               },
//                               child: Card(
//                                 elevation: 2.0,
//                                 margin:
//                                 const EdgeInsets.symmetric(vertical: 8.0),
//                                 child: ListTile(
//                                   title: Text(
//                                     task.taskName,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text(task.taskDescription),
//                                       const SizedBox(height: 4.0),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Priority: ${task.taskPriority}',
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   trailing: Checkbox(
//                                     value: completed,
//                                     onChanged: (value) {
//                                       final val;
//                                       if (value == true) {
//                                         val = 1;
//                                       } else {
//                                         val = 0;
//                                       }
//                                       final tasks = Task(
//                                         id: task.id,
//                                         taskName: task.taskName,
//                                         taskDescription: task.taskDescription,
//                                         taskPriority: task.taskPriority,
//                                       );
//                                       QuickeyDB.getInstance!<TaskSchema>()!
//                                           .update(tasks..isCompleted = val);
//                                       setState(() {});
//                                       // Update task completion status
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                           content: Text('Task status updated'),
//                                           backgroundColor: Colors.green,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               return const Center(child: CircularProgressIndicator());
//             }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newTask = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddTodoScreen()),
//           );
//
//           if (newTask != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Task added successfully'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//             setState(() {});
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   Future<void> deleteTask(task) async {
//     await QuickeyDB.getInstance!<TaskSchema>()!.delete(task);
//     // Simulate deletion with a delay
//
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _isLoading = false; // Hide loading indicator
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Task deleted successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       setState(() {});
//     });
//   }
// }
