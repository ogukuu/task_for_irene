import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/forms/calendar_top_bar.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

import 'forms/day/calendar_day_form.dart';
import 'forms/month/calendar_month_form.dart';
import 'forms/year/calendar_year_form.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key, required this.controller}) : super(key: key);
  final CalendarController controller;

  Widget _getPeriodTypeWidget() {
    switch (controller.period.periodType) {
      case PeriodType.year:
        return CalendarYearForm(dates: controller.period.dates);
      case PeriodType.day:
        return CalendarDayForm(controller: controller);
      case PeriodType.month:
      default:
        return CalendarMonthForm(
          days: controller.period
              .getExtendedMonthDates(controller.firstDayOfTheWeek),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Column(
          children: [
            CalendarTopBar(
              controller: controller,
            ),
            _getPeriodTypeWidget()
          ],
        );
      },
    );
  }
}
