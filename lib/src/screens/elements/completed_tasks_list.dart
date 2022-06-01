import 'package:flutter/material.dart';
import 'package:task_for_irene/src/screens/elements/completed_task_card.dart';
import '../../models/task.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      restorationId: 'completedTasksListView',
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          CompletedTaskCard(tasks[index]),
    );
  }
}
