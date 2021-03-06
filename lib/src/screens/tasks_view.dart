import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/screens/elements/active_tasks_list.dart';
import 'package:task_for_irene/src/screens/elements/completed_tasks_list.dart';
import 'package:task_for_irene/src/screens/elements/my_floating_action_button.dart';
import 'package:task_for_irene/src/task/task.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key, required this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          floatingActionButton: AddTaskFloatingActionButton(context: context),
          appBar: AppBar(
            elevation: 2,
            automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.tasksListViewTitle),
            actions: [
              IconButton(
                tooltip:
                    AppLocalizations.of(context)!.tasksListViewToCalendarButton,
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  Navigator.restorablePushNamed(context, NavRoute.calendar);
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
                  Navigator.restorablePushNamed(context, NavRoute.settings);
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
              ActiveTasksList(tasks: GlobalVar.appController.activeTasks),
              CompletedTasksList(
                tasks: GlobalVar.appController.completedTasks,
              )
            ],
          )),
    );
  }
}
