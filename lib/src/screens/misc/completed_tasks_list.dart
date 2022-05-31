import 'package:flutter/material.dart';
import 'package:task_for_irene/src/screens/misc/completed_task_card.dart';
import '../../models/task.dart';

class CompletedTasksList extends StatelessWidget {
  const CompletedTasksList(this._tasks, {Key? key}) : super(key: key);

  final List<Task> _tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      restorationId: 'completedTasksListView',
      itemCount: _tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          CompletedTaskCard(_tasks[index]),
    );
  }
}
