import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/month/day_of_the_month.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';

class CalendarMonthForm extends StatelessWidget {
  const CalendarMonthForm({Key? key, required this.controller})
      : super(key: key);
  final CalendarController controller;

  Widget _title() {
    return Text(
        CalendarUtilits.getNameMonth(controller.period.dates.first.month));
  }

  Widget _body() {
    return Table(
      children: _getTableRow(),
    );
  }

  List<TableRow> _getTableRow() {
    List<DateTime> days =
        controller.period.getExtendedMonthDates(DateTime.monday);
    List<TableRow> tableRowList = [];
    for (var i = 0; i < days.length ~/ 7; i++) {
      tableRowList.add(TableRow(
          children: days
              .getRange(i * 7, i * 7 + 7)
              .map((e) => DayOfTheMonth(
                  date: e, month: controller.period.dates.first.month))
              .toList()));
    }
    return tableRowList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_title(), _body()],
    );
  }
}
