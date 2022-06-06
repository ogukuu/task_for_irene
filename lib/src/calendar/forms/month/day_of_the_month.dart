import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/sub_period.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

class DayOfTheMonth extends StatelessWidget {
  const DayOfTheMonth({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    CalendarController controller = GlobalVar.appController.calendarController;
    double maxWidth = MediaQuery.of(context).size.width;
    bool isWeekend = (date.weekday == DateTime.sunday) ||
        (date.weekday == DateTime.saturday);
    bool isNow = currentDay(date);
    bool active = ((date.month == controller.period.month) &&
        (DateTime.now().isBefore(date) || isNow));
    double elevation = (active) ? 2 : 0;
    bool isTask = GlobalVar.appController.isTaskForThisDay(date);
    Brightness brightness =
        GlobalVar.appController.getCurrentBrightness(context);
    return SubPeriod(
        onActive: active,
        width: maxWidth / 7,
        onTap: () => controller.down(date),
        child: Card(
            color: getColor(
                isNow: isNow, isWeekend: isWeekend, brightness: brightness),
            shape: getShape(isTask: isTask),
            elevation: elevation,
            child: Center(child: Text(date.day.toString()))));
  }
}
