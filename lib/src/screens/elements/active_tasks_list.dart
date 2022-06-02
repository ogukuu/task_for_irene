import 'package:flutter/material.dart';
import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/screens/elements/active_task_card.dart';
import '../../models/task.dart';

class ActiveTasksList extends StatelessWidget {
  const ActiveTasksList({Key? key, required this.controller}) : super(key: key);
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = controller.activeTasks;
    return ListView.builder(
      restorationId: 'activeTasksListView',
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          ActiveTaskCard(controller: controller, task: tasks[index]),
    );
  }
}
