import 'package:flutter/material.dart';
import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/screens/elements/completed_task_card.dart';
import '../../models/task.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList({Key? key, required this.controller})
      : super(key: key);

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = controller.completedTasks;
    return ListView.builder(
      primary: false,
      restorationId: 'completedTasksListView',
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          CompletedTaskCard(tasks[index]),
    );
  }
}
