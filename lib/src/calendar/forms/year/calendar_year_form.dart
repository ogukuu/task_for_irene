import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/forms/year/month_of_the_year.dart';

class CalendarYearForm extends StatelessWidget {
  const CalendarYearForm({Key? key, required this.dates}) : super(key: key);

  final List<DateTime> dates;

  Widget _body() {
    return Table(
      children: _getTableRow(),
    );
  }

  List<TableRow> _getTableRow() {
    List<TableRow> tableRowList = [];
    for (var i = 0; i < 4; i++) {
      tableRowList.add(TableRow(
          children: dates
              .getRange(i * 3, i * 3 + 3)
              .map((e) => MonthOfTheYear(date: e))
              .toList()));
    }
    return tableRowList;
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }
}
