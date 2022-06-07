import 'package:flutter/material.dart';
import 'package:task_for_irene/src/task/task.dart';
import '../../navigation/nav_route.dart';
import '../../utilits/format_date.dart';
import 'action_button.dart';

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final double indent = MediaQuery.of(context).size.width / 12;
    final double padding = indent / 4;
    return GestureDetector(
      onTap: () =>
          Navigator.restorablePushNamed(context, NavRoute.activeTask + task.id),
      child: Column(children: [
        Divider(
          thickness: 1,
          height: 0,
          endIndent: indent,
          indent: indent,
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: _Body(
            title: task.title,
            dueDate: task.dueDate,
            id: task.id,
          ),
        ),
        Divider(
          thickness: 1,
          height: 0,
          endIndent: indent,
          indent: indent,
        ),
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(
      {Key? key, required this.title, required this.dueDate, required this.id})
      : super(key: key);
  final String title;
  final DateTime dueDate;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _DueDate(dueDate: dueDate),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _Title(title: title),
              )
            ],
          ),
        ),
        ActionButton(id: id)
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        textScaleFactor: 1.2,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _DueDate extends StatelessWidget {
  const _DueDate({Key? key, required this.dueDate}) : super(key: key);
  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, child: Text(getDDMMYYYY(dueDate)));
  }
}
