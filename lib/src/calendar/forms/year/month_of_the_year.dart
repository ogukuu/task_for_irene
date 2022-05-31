import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';

class MonthOfTheYear extends StatelessWidget {
  const MonthOfTheYear({Key? key, required this.date, required this.controller})
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
                child: Center(
              child: Text(
                CalendarUtilitsByContext.of(context).getNameMonth(date.month),
                overflow: TextOverflow.ellipsis,
              ),
            ))),
      ),
    );
  }
}
