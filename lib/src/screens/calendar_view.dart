import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/calendar/calendar.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';

import '../models/task.dart';
import 'elements/active_task_card.dart';
import 'elements/completed_task_card.dart';
import 'elements/my_floating_action_button.dart';

class CalendarView extends StatelessWidget {
  CalendarView({Key? key, required this.controller}) : super(key: key) {
    calendarController = controller.calendarController;
    tasks.addAll(controller.tasks);
    tasks.sort(((a, b) {
      return a.dueDate.compareTo(b.dueDate);
    }));
  }

  final AppController controller;
  final List<Task> tasks = [];
  late final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        context: context,
        onPressed: () {
          Navigator.restorablePushNamed(context, NavRoute.addTask);
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.calendarViewTitle),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context)!.calendarViewToTasksButton,
            icon: const Icon(Icons.tab_outlined),
            onPressed: () {
              Navigator.restorablePushNamed(context, NavRoute.tasks);
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
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: tasks.length + 2,
            (context, index) {
              if (index == 0) return Calendar(controller: calendarController);
              if (index == 1) return const Divider();
              if (tasks[index - 2].status == StatusTask.active) {
                return ActiveTaskCard(tasks[index - 2]);
              } else {
                return CompletedTaskCard(tasks[index - 2]);
              }
            },
          ))
        ],
      ),
    );
  }
}
