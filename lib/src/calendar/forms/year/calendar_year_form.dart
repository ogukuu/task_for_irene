import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/year/month_of_the_year.dart';

class CalendarYearForm extends StatelessWidget {
  const CalendarYearForm({Key? key, required this.controller})
      : super(key: key);
  final CalendarController controller;

  Widget _body() {
    return Table(
      children: _getTableRow(),
    );
  }

  List<TableRow> _getTableRow() {
    List<TableRow> tableRowList = [];
    for (var i = 0; i < 4; i++) {
      tableRowList.add(TableRow(
          children: controller.period.dates
              .getRange(i * 3, i * 3 + 3)
              .map((e) => MonthOfTheYear(date: e, controller: controller))
              .toList()));
    }
    return tableRowList;
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
