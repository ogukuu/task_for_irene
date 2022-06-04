import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/calendar/calendar.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';

import '../models/task.dart';
import 'elements/active_task_card.dart';
import 'elements/my_floating_action_button.dart';

class CalendarView extends StatelessWidget {
  CalendarView({Key? key, required this.activeTasks}) : super(key: key) {
    calendarController = GlobalVar.appController.calendarController;
    activeTasks.sort(((a, b) {
      return a.dueDate.compareTo(b.dueDate);
    }));
  }

  final List<Task> activeTasks;
  late final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddTaskFloatingActionButton(context: context),
      appBar: AppBar(
        elevation: 2,
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
            childCount: activeTasks.length + 2,
            (context, index) {
              if (index == 0) return Calendar(controller: calendarController);
              if (index == 1) return const Divider();
              return ActiveTaskCard(task: activeTasks[index - 2]);
            },
          ))
        ],
      ),
    );
  }
}
