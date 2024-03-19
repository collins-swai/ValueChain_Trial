
class Task {

  int? id;
  String taskName;
  String taskDescription;
  String taskPriority;
  int? isCompleted;



  Task({
    this.id,
    required this.taskName,
    required this.taskDescription,
    required this.taskPriority,
     this.isCompleted,

  });

  Task.fromMap(Map<String?, dynamic> map)
      : id = map['id'],
        taskName = map['task_name'],
        taskDescription = map['task_description'],
        taskPriority = map['task_priority'],
       isCompleted = map['is_completed'];

  Map<String, dynamic> toMap() => {
    'id': id,
    'task_name': taskName,
    'task_description': taskDescription,
    'task_priority': taskPriority,
    'is_completed': isCompleted,

  };

  Map<String, dynamic> toTableMap() => {
    'id': id,
    'task_name': taskName,
    'task_description': taskDescription,
    'task_priority': taskPriority,
    'is_completed': isCompleted,
  };
}
