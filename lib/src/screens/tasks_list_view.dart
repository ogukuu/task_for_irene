import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/screens/calendar_view.dart';

import '../models/task.dart';
import '../settings/settings_view.dart';

class TasksListView extends StatelessWidget {
  const TasksListView(this._tasks, {Key? key}) : super(key: key);

  static const routeName = '/tasks';
  final List<Task> _tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.tasksListViewTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () {
              Navigator.restorablePushNamed(context, CalendarView.routeName);
            },
          ),
          const VerticalDivider(
            indent: 10,
            endIndent: 10,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: const Text("TasksListView"),
    );
  }
}
