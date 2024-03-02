import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../viewmodels/task_view_model.dart';
import '../widgets/task_list.dart';
import 'add_task_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDoList App'),
      ),
      body: ListView.builder(
        itemCount: viewModel.tasks.length,
        itemBuilder: (context, index) {
          final task = viewModel.tasks[index];
          return TaskItem(task: task, index: index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddTaskPage(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddTaskPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage()),
    );

    if (result != null) {
      Provider.of<TaskViewModel>(context, listen: false).addTask(result as Task);
    }
  }
}
