import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

import 'forms/day/calendar_day_form.dart';
import 'forms/month/calendar_month_form.dart';
import 'forms/year/calendar_year_form.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key, required this.controller}) : super(key: key);
  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    switch (controller.period.periodType) {
      case PeriodType.year:
        return CalendarYearForm(controller: controller);
      case PeriodType.day:
        return CalendarDayForm(controller: controller);
      case PeriodType.month:
      default:
        return CalendarMonthForm(controller: controller);
    }
  }
}
