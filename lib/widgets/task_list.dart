import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../screens/add_task_screen.dart';
import '../viewmodels/task_view_model.dart';



class TaskItem extends StatelessWidget {
  final Task task;
  final int index;

  TaskItem({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          SizedBox(height: 4),
          Text('Priority: ${_getPriorityString(task.priority)}'),
          Text('Due Date: ${DateFormat('MMM dd, yyyy').format(task.dueDate)}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _navigateToEditTaskPage(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteTask(context);
            },
          ),
        ],
      ),
    );
  }

  String _getPriorityString(int priority) {
    switch (priority) {
      case 0:
        return 'Low';
      case 1:
        return 'Medium';
      case 2:
        return 'High';
      case 3:
        return 'Critical';
      default:
        return 'Unknown';
    }
  }

  void _navigateToEditTaskPage(BuildContext context) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage(task: task)),
    );

    if (editedTask != null) {
      Provider.of<TaskViewModel>(context, listen: false).updateTask(index, editedTask as Task);
    }
  }

  void _deleteTask(BuildContext context) {
    Provider.of<TaskViewModel>(context, listen: false).deleteTask(index);
  }
}
