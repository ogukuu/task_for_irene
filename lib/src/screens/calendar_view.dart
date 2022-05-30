import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/screens/tasks_view.dart';

import '../models/task.dart';
import '../settings/settings_view.dart';
import 'misc/active_task_card.dart';
import 'misc/completed_task_card.dart';
import 'misc/my_floating_action_button.dart';

class CalendarView extends StatelessWidget {
  CalendarView(this._tasks, {Key? key}) : super(key: key) {
    _tasks.sort(((a, b) {
      return a.dueDate.compareTo(b.dueDate);
    }));
  }

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
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: _tasks.length + 2,
            (context, index) {
              if (index == 0) return const Text('calendar');
              if (index == 1) return const Divider();
              if (_tasks[index - 2].status == StatusTask.active) {
                return ActiveTaskCard(_tasks[index - 2]);
              } else {
                return CompletedTaskCard(_tasks[index - 2]);
              }
            },
          ))
        ],
      ),
    );
  }
}
