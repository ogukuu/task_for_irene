import 'package:flutter/material.dart';

class DayOfTheMonth extends StatelessWidget {
  const DayOfTheMonth({Key? key, required this.date, required this.month})
      : super(key: key);
  final DateTime date;
  final int month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
          width: 50,
          height: 50,
          child: Card(
              elevation: (date.month == month) ? 1 : 0,
              clipBehavior: Clip.hardEdge,
              child: Text(date.day.toString()))),
    );
  }
}
