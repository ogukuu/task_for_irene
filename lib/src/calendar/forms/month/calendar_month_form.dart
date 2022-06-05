import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/month/day_of_the_month.dart';

class CalendarMonthForm extends StatelessWidget {
  const CalendarMonthForm({Key? key, required this.controller})
      : super(key: key);
  final CalendarController controller;

  Widget _body() {
    return Table(
      children: _getTableRow(),
    );
  }

  List<TableRow> _getTableRow() {
    List<DateTime> days =
        controller.period.getExtendedMonthDates(controller.firstDayOfTheWeek);
    List<TableRow> tableRowList = [];
    for (var i = 0; i < days.length ~/ 7; i++) {
      tableRowList.add(TableRow(
          children: days
              .getRange(i * 7, i * 7 + 7)
              .map((e) => DayOfTheMonth(date: e, controller: controller))
              .toList()));
    }
    return tableRowList;
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
