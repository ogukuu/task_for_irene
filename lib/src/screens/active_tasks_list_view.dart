import 'package:flutter/material.dart';
import 'package:task_for_irene/src/screens/misc/active_task_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/task.dart';
import '../settings/settings_view.dart';

class ActiveTasksListView extends StatelessWidget {
  const ActiveTasksListView(this._tasks, {Key? key}) : super(key: key);

  static const routeName = '/active_tasks';
  final List<Task> _tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.activeTasksListViewTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'activeTasksListView',
        itemCount: _tasks.length,
        itemBuilder: (BuildContext context, int index) =>
            ActiveTaskCard(_tasks[index]),
      ),
    );
  }
}
