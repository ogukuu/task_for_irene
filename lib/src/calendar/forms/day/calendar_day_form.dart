import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/day/hour_of_the_%20day.dart';

class CalendarDayForm extends StatelessWidget {
  const CalendarDayForm({Key? key, required this.controller}) : super(key: key);
  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          controller.period.dates.map((e) => HourOfTheDay(date: e)).toList(),
    );
  }
}
