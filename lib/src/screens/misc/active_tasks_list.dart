import 'package:flutter/material.dart';
import 'package:task_for_irene/src/screens/misc/active_task_card.dart';
import '../../models/task.dart';

class ActiveTasksList extends StatelessWidget {
  const ActiveTasksList(this._tasks, {Key? key}) : super(key: key);

  final List<Task> _tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      restorationId: 'activeTasksListView',
      itemCount: _tasks.length,
      itemBuilder: (BuildContext context, int index) =>
          ActiveTaskCard(_tasks[index]),
    );
  }
}
