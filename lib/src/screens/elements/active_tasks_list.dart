import 'package:flutter/material.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/screens/elements/active_task_card.dart';
import '../../models/task.dart';

class ActiveTasksList extends StatelessWidget {
  ActiveTasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = GlobalVar.appController.activeTasks;
    return ListView.builder(
      restorationId: 'activeTasksListView',
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          ActiveTaskCard(task: tasks[index]),
    );
  }
}
