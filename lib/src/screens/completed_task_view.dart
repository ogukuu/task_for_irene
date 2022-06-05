import 'package:flutter/material.dart';
import 'package:task_for_irene/src/utilits/task_utilits.dart';

import '../models/task.dart';

class CompletedTaskView extends StatelessWidget {
  const CompletedTaskView({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
      ),
      body: _bogy(),
    );
  }

  Widget _bogy() {
    List<Widget> widgets = [
      _Title(task: task),
      const Divider(),
      _ProofPhoto(task: task),
      const Divider(),
      _Description(task: task)
    ];
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 5,
          (context, index) => widgets[index],
        ))
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(task.title,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.3,
          textAlign: TextAlign.center),
    );
  }
}

class _ProofPhoto extends StatelessWidget {
  const _ProofPhoto({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FittedBox(
          fit: BoxFit.cover,
          child:
              getStatusImage(status: task.status, photoProof: task.photoProof)),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Text(task.description);
  }
}
