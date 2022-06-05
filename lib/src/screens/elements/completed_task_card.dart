import 'package:flutter/material.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';

import '../../models/task.dart';
import '../../utilits/task_utilits.dart';

class CompletedTaskCard extends StatelessWidget {
  const CompletedTaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final double maxWidthProofPhoto = MediaQuery.of(context).size.width / 3;
    final double indent = maxWidthProofPhoto / 4;
    return GestureDetector(
      onTap: (() => Navigator.restorablePushNamed(
          context, NavRoute.comletedTask + task.id)),
      child: Column(
        children: [
          Divider(
            thickness: 1,
            height: 0,
            endIndent: indent,
            indent: indent,
          ),
          Padding(
            padding: EdgeInsets.all(indent / 8),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  _ProofPhoto(
                      maxSize: maxWidthProofPhoto,
                      status: task.status,
                      photoProof: task.photoProof),
                  Expanded(
                      child: _TaskInfo(
                          title: task.title,
                          description: testDescription(task))) // TEST
                ]),
          ),
          Divider(
            thickness: 1,
            height: 0,
            endIndent: indent,
            indent: indent,
          )
        ],
      ),
    );
  }
}

class _ProofPhoto extends StatelessWidget {
  const _ProofPhoto(
      {Key? key,
      required this.maxSize,
      required this.photoProof,
      required this.status})
      : super(key: key);

  final double maxSize;
  final dynamic photoProof;
  final String status;

  final double defSize = 128;

  @override
  Widget build(BuildContext context) {
    double currentSize = defSize > maxSize ? maxSize : defSize;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
          width: currentSize,
          height: currentSize,
          child: Card(
              elevation: 1,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child:
                      getStatusImage(status: status, photoProof: photoProof)))),
    );
  }
}

class _TaskInfo extends StatelessWidget {
  const _TaskInfo({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1.2,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        )
      ]),
    );
  }
}
