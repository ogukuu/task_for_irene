import 'package:flutter/material.dart';
import 'package:task_for_irene/src/screens/elements/completed_task_card.dart';
import 'package:task_for_irene/src/task/task.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList({Key? key, required this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      restorationId: 'completedTasksListView',
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          CompletedTaskCard(task: tasks[index]),
    );
  }
}
