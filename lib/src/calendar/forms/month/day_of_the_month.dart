import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';

class DayOfTheMonth extends StatelessWidget {
  const DayOfTheMonth({Key? key, required this.date, required this.controller})
      : super(key: key);
  final DateTime date;
  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.updatePeriodType(controller.period.down(date)),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SizedBox(
            width: 50,
            height: 50,
            child: Card(
                elevation: (date.month == controller.period.month) ? 1 : 0,
                child: Center(
                  child: Text(date.day.toString()),
                ))),
      ),
    );
  }
}