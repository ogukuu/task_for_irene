// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/forms/sub_period.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/task/task.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

class HourOfTheDay extends StatelessWidget {
  const HourOfTheDay({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = GlobalVar.appController.taskForThisHour(date);
    List<Widget> getWidgets() {
      List<Widget> temp = [];
      temp.addAll([
        Text(getHHMMDateTime(date)),
        const Divider(),
      ]);
      if (tasks.isNotEmpty) {
        for (var e in tasks) {
          temp.add(GestureDetector(
            onTap: () => Navigator.restorablePushNamed(
                context, NavRoute.activeTask + e.id),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ));
        }
      } else {
        temp.add(const Text(""));
      }
      return temp;
    }

    bool isNow = currentHour(date);
    bool active = (DateTime.now().isBefore(date) || isNow);
    double elevation = (active) ? 2 : 0;
    bool isTask = GlobalVar.appController.isTaskForThisHour(date);
    return SubPeriod(
        onLongPress: () {
          Navigator.restorablePushNamed(
              context, NavRoute.addTaskWithDate + toURL(date));
        },
        onActive: active,
        onTap: () {},
        child: Card(
          shape: getShape(isTask: isTask),
          elevation: elevation,
          color: getColor(isNow: isNow),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getWidgets(),
            ),
          ),
        ));
  }
}
