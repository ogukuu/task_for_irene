import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../utilits/format_date.dart';

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard(this.task, {Key? key}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      _ActiveTaskTitle(task: task),
      const Divider(height: 0, indent: 10, endIndent: 10),
      _ActiveTaskDescription(task: task)
    ]));
  }
}

class _ActiveTaskDescription extends StatelessWidget {
  const _ActiveTaskDescription({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          "${task.description} ${task.testDescription()}",
        ));
  }
}

class _ActiveTaskTitle extends StatelessWidget {
  const _ActiveTaskTitle({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            child: Text(
              task.title,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.3,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(10),
              child: Text("due date: ${formatDate(task.dueDate)}")),
        )
      ],
    );
  }
}
