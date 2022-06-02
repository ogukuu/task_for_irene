import 'package:flutter/material.dart';
import 'package:task_for_irene/src/app_controller.dart';
import '../../models/task.dart';
import '../../navigation/nav_route.dart';
import '../../utilits/format_date.dart';

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard({Key? key, required this.controller, required this.task})
      : super(key: key);
  final Task task;
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.restorablePushNamed(
          context, NavRoute.activeTask + task.id)),
      child: Card(
          elevation: 1,
          child: Column(children: [
            _ActiveTaskTitle(
              task: task,
              controller: controller,
            ),
            const Divider(height: 0, indent: 10, endIndent: 10),
            _ActiveTaskDescription(task: task)
          ])),
    );
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
    required this.controller,
  }) : super(key: key);

  final Task task;
  final AppController controller;

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
        ),
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.centerRight,
                child: _ActionButton(
                  controller: controller,
                  task: task,
                )))
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key, required this.controller, required this.task})
      : super(key: key);
  final AppController controller;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Actions>(
        //icon: const Icon(Icons.arrow_drop_down),
        tooltip: "Action",
        elevation: 2,
        // Callback that sets the selected popup menu item.
        onSelected: (Actions item) {
          switch (item) {
            case Actions.delete:
              controller.deleteTask(task);
              break;
            case Actions.proof:
              break;
            case Actions.surrender:
              controller.surrenderTask(task);
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Actions>>[
              const PopupMenuItem<Actions>(
                value: Actions.delete,
                child: Text('delete'),
              ),
              const PopupMenuItem<Actions>(
                value: Actions.surrender,
                child: Text('surrender'),
              ),
              const PopupMenuItem<Actions>(
                value: Actions.proof,
                child: Text('proof'),
              ),
            ]);
  }
}

enum Actions { delete, surrender, proof }
