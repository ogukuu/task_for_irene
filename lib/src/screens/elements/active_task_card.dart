import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/utilits/task_utilits.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/task.dart';
import '../../navigation/nav_route.dart';
import '../../utilits/format_date.dart';

class ActiveTaskCard extends StatelessWidget {
  const ActiveTaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.restorablePushNamed(
          context, NavRoute.activeTask + task.id)),
      child: Card(
          elevation: 1,
          child: Column(children: [
            _ActiveTaskTitle(
                title: task.title, id: task.id, dueDate: task.dueDate),
            const Divider(height: 0, indent: 10, endIndent: 10),
            _ActiveTaskDescription(description: testDescription(task))
          ])),
    );
  }
}

class _ActiveTaskDescription extends StatelessWidget {
  const _ActiveTaskDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        child: Text(description));
  }
}

class _ActiveTaskTitle extends StatelessWidget {
  const _ActiveTaskTitle(
      {Key? key, required this.title, required this.id, required this.dueDate})
      : super(key: key);

  final String title;
  final String id;
  final DateTime dueDate;

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
              title,
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
              child: Text("due date: ${formatDate(dueDate)}")),
        ),
        Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.centerRight, child: _ActionButton(id: id)))
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key, required this.id}) : super(key: key);
  final String id;
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
              GlobalVar.appController.deleteTaskAtId(id);
              break;
            case Actions.proof:
              if (Platform.isAndroid) print("proof");
              ;
              break;
            case Actions.surrender:
              GlobalVar.appController.surrenderTaskAtId(id);
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Actions>>[
              PopupMenuItem<Actions>(
                value: Actions.proof,
                child: Text(AppLocalizations.of(context)!
                    .activeTaskCardActionProvideProof),
              ),
              PopupMenuItem<Actions>(
                value: Actions.surrender,
                child: Text(AppLocalizations.of(context)!
                    .activeTaskCardActionSurrender),
              ),
              PopupMenuItem<Actions>(
                value: Actions.delete,
                child: Text(
                    AppLocalizations.of(context)!.activeTaskCardActionDelete),
              )
            ]);
  }
}

enum Actions { delete, surrender, proof }
