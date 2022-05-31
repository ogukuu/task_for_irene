// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HourOfTheDay extends StatelessWidget {
  const HourOfTheDay({Key? key, required this.date}) : super(key: key);
  final DateTime date;

  String dateText() {
    String h =
        (date.hour < 10) ? "0${date.hour.toString()}" : date.hour.toString();
    String m = (date.minute < 10)
        ? "0${date.minute.toString()}"
        : date.minute.toString();
    return "$h : $m";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(dateText()), const Divider(), const Text("")],
        ),
      ),
    );
  }
}
