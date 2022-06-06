import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/sub_period.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

class DayOfTheMonth extends StatelessWidget {
  const DayOfTheMonth({Key? key, required this.date, required this.controller})
      : super(key: key);
  final DateTime date;
  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    bool active = date.month == controller.period.month; // переделать

    double elevation = (active) ? 2 : 0;
    double maxWidth = MediaQuery.of(context).size.width;
    bool isWeekend = (date.weekday == DateTime.sunday) ||
        (date.weekday == DateTime.saturday);
    bool isNow = currentDay(date);
    bool isTask = GlobalVar.appController.isTaskForThisDay(date);
    Brightness brightness =
        GlobalVar.appController.getCurrentBrightness(context);
    return SubPeriod(
        onActive: active,
        width: maxWidth / 7,
        onTap: () => controller.updatePeriodType(controller.period.down(date)),
        child: Card(
            color: _getColor(
                isNow: isNow, isWeekend: isWeekend, brightness: brightness),
            shape: _getShape(isTask: isTask),
            elevation: elevation,
            child: Center(child: Text(date.day.toString()))));
  }
}

Color? _getColor(
    {bool isNow = false,
    bool isWeekend = false,
    Brightness brightness = Brightness.light}) {
  if (isNow) return Colors.green.shade500;
  if (isWeekend) {
    return (brightness == Brightness.light)
        ? Colors.blue.shade100
        : Colors.grey.shade700;
  }
  return null;
}

ShapeBorder? _getShape({bool isTask = false}) {
  if (isTask) {
    return ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.blue, width: 3));
  }
  return null;
}
