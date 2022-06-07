import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/forms/sub_period.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

class MonthOfTheYear extends StatelessWidget {
  const MonthOfTheYear({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    bool isNow = currentMonth(date);
    bool active = (DateTime.now().isBefore(date) || isNow);
    double elevation = (active) ? 2 : 0;
    bool isTask = GlobalVar.appController.isTaskForThisMonth(date);
    double width = maxWidth / 3;
    double height = width / GlobalVar.goldenRatio;
    return SubPeriod(
        onLongPress: () {
          Navigator.restorablePushNamed(
              context, NavRoute.addTaskWithDate + toURL(date));
        },
        onActive: active,
        width: width,
        height: height,
        onTap: () => GlobalVar.appController.calendarController.down(date),
        child: Card(
            color: getColor(isNow: isNow),
            shape: getShape(isTask: isTask),
            elevation: elevation,
            child: Center(
                child: Text(
              CalendarUtilitsByContext.of(context).getNameMonth(date.month),
              overflow: TextOverflow.ellipsis,
            ))));
  }
}
