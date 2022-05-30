import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key, this.firstDayOfTheWeek = FirstDayOfTheWeek.monday})
      : super(key: key);
  final FirstDayOfTheWeek firstDayOfTheWeek;
  PeriodType calendarFormType = PeriodType.month;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
