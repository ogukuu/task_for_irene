import 'package:flutter/material.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';

import '../../models/task.dart';
import '../../utilits/task_utilits.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard(this.task, {Key? key}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final double maxWidthProofPhoto = MediaQuery.of(context).size.width / 3;
    return GestureDetector(
      onTap: (() => Navigator.restorablePushNamed(
          context, NavRoute.comletedTask + task.id)),
      child: Card(
          elevation: 1,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
                _ProofPhoto(maxSize: maxWidthProofPhoto, task: task),
                Expanded(child: _TaskInfo(task: task))
              ])),
    );
  }
}

class _ProofPhoto extends StatelessWidget {
  const _ProofPhoto({Key? key, required this.maxSize, required this.task})
      : super(key: key);

  final double maxSize;
  final Task task;

  final double defSize = 128;

  @override
  Widget build(BuildContext context) {
    double currentSize = defSize > maxSize ? maxSize : defSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: currentSize,
          height: currentSize,
          child: Card(
              clipBehavior: Clip.hardEdge,
              child:
                  FittedBox(fit: BoxFit.cover, child: getStatusImage(task)))),
    );
  }
}

class _TaskInfo extends StatelessWidget {
  const _TaskInfo({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          task.title,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.3,
        ),
        const Divider(height: 16, indent: 10, endIndent: 10),
        Text("${task.description} ${task.testDescription()}")
      ]),
    );
  }
}
