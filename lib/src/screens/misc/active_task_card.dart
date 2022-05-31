import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../utilits/format_date.dart';

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard(this._task, {Key? key}) : super(key: key);
  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              child: Text(
                _task.title,
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
                child: Text("due date: ${formatDate(_task.dueDate)}")),
          )
        ],
      ),
      const Divider(height: 0, indent: 10, endIndent: 10),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: Text(
            _task.description,
          ))
    ]));
  }
}
