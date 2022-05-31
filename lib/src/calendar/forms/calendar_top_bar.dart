import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

import '../../utilits/fix.dart';
import '../calendar_controller.dart';

class CalendarTopBar extends StatelessWidget {
  const CalendarTopBar({Key? key, required this.controller}) : super(key: key);
  final CalendarController controller;

  Widget _prev(BuildContext context) {
    return ElevatedButton(
        style:
            ButtonStyle(backgroundColor: elevatedButtonBackgroundFix(context)),
        onPressed: () {
          controller.updatePeriodType(controller.period.prev());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            const Icon(Icons.arrow_back_ios),
            Text(_prevTitle(context))
          ]),
        ));
  }

  String _prevTitle(BuildContext context) {
    switch (controller.period.periodType) {
      case PeriodType.month:
        return CalendarUtilitsByContext.of(context)
            .getShortNameMonth(controller.period.prev().month); // .prev()
      case PeriodType.year:
        return (controller.period.dates.first.year - 1).toString();
      case PeriodType.day:
        return controller.period.prev().dates.first.day.toString();
    }
  }

  Widget _up(BuildContext context) {
    return TextButton(
        onPressed: (() {
          controller.updatePeriodType(controller.period.up());
        }),
        child: Text(
          _upTitle(context),
          style: Theme.of(context).textTheme.button,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.3,
        ));
  }

  String _upTitle(BuildContext context) {
    String currentMonthText = CalendarUtilitsByContext.of(context)
        .getNameMonth(controller.period.month);
    int currentYear = controller.period.dates.first.year;
    int currentDay = controller.period.dates.first.day;
    switch (controller.period.periodType) {
      case PeriodType.month:
        return "$currentMonthText, $currentYear";
      case PeriodType.year:
        return currentYear.toString();
      case PeriodType.day:
        return "$currentDay $currentMonthText $currentYear";
    }
  }

  Widget _next(BuildContext context) {
    return ElevatedButton(
        style:
            ButtonStyle(backgroundColor: elevatedButtonBackgroundFix(context)),
        onPressed: (() {
          controller.updatePeriodType(controller.period.next());
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Text(_nextTitle(context)),
            const Icon(Icons.arrow_forward_ios)
          ]),
        ));
  }

  String _nextTitle(BuildContext context) {
    switch (controller.period.periodType) {
      case PeriodType.month:
        return CalendarUtilitsByContext.of(context)
            .getShortNameMonth(controller.period.next().month); // .next()
      case PeriodType.year:
        return (controller.period.dates.first.year + 1).toString();
      case PeriodType.day:
        return controller.period.next().dates.first.day.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _prev(context),
          Expanded(child: _up(context)),
          _next(context)
        ],
      ),
    );
  }
}
