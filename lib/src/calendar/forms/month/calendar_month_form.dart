import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/forms/month/day_of_the_month.dart';

class CalendarMonthForm extends StatelessWidget {
  const CalendarMonthForm({Key? key, required this.days}) : super(key: key);

  final List<DateTime> days;

  Widget _body() {
    return Table(
      children: _getTableRow(),
    );
  }

  List<TableRow> _getTableRow() {
    List<TableRow> tableRowList = [];
    for (var i = 0; i < days.length ~/ 7; i++) {
      tableRowList.add(TableRow(
          children: days
              .getRange(i * 7, i * 7 + 7)
              .map((e) => DayOfTheMonth(date: e))
              .toList()));
    }
    return tableRowList;
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
