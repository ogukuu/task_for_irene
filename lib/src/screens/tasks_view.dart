import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/screens/add_task_view.dart';
import 'package:task_for_irene/src/screens/calendar_view.dart';
import 'package:task_for_irene/src/screens/elements/active_tasks_list.dart';
import 'package:task_for_irene/src/screens/elements/completed_tasks_list.dart';
import 'package:task_for_irene/src/screens/elements/my_floating_action_button.dart';

import '../models/task.dart';
import '../settings/settings_view.dart';

class TasksView extends StatelessWidget {
  const TasksView(this._tasks, {Key? key}) : super(key: key);

  static const routeName = '/tasks';
  final List<Task> _tasks;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          floatingActionButton: MyFloatingActionButton(
            context: context,
            onPressed: () {
              Navigator.restorablePushNamed(context, AddTaskView.routeName);
            },
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.tasksListViewTitle),
            actions: [
              IconButton(
                tooltip:
                    AppLocalizations.of(context)!.tasksListViewToCalendarButton,
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, CalendarView.routeName);
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
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
              )
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: AppLocalizations.of(context)!.tasksListViewActive,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.tasksListViewCompleted,
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ActiveTasksList(_tasks),
              CompletedTasksList(_tasks)
            ],
          )),
    );
  }
}
