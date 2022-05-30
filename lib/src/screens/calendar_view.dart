import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/screens/tasks_view.dart';

import '../models/task.dart';
import '../settings/settings_view.dart';
import 'misc/my_floating_action_button.dart';

class CalendarView extends StatelessWidget {
  const CalendarView(this._tasks, {Key? key}) : super(key: key);

  static const routeName = '/calendar';
  final List<Task> _tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        context: context,
        onPressed: () {},
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.calendarViewTitle),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context)!.calendarViewToTasksButton,
            icon: const Icon(Icons.tab_outlined),
            onPressed: () {
              Navigator.restorablePushNamed(context, TasksView.routeName);
            },
          ),
          const VerticalDivider(
            indent: 10,
            endIndent: 10,
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.settingsButtonTooltip,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: const Text("CalendarView"),
    );
  }
}
