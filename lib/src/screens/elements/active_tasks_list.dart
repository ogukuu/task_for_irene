import 'package:flutter/material.dart';
import 'package:task_for_irene/src/screens/elements/active_task_card.dart';
import '../../models/task.dart';

class ActiveTasksList extends StatelessWidget {
  const ActiveTasksList(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      restorationId: 'activeTasksListView',
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          ActiveTaskCard(tasks[index]),
    );
  }
}
