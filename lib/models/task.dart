class Task {
  String title;
  String description;
  DateTime dueDate;
  int priority;

  Task({required this.title, required this.description, required this.dueDate, required this.priority});

  Task.clone(Task task)
      : title = task.title,
        description = task.description,
        dueDate = task.dueDate,
        priority = task.priority;
}
