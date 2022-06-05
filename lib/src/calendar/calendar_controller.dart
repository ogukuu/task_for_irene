import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

class CalendarController extends ChangeNotifier {
  CurrentPeriod period;
  int _firstDayOfTheWeek;
  int get firstDayOfTheWeek => _firstDayOfTheWeek;

  CalendarController(this.period, [this._firstDayOfTheWeek = DateTime.monday]);

  void updatePeriodType(CurrentPeriod? newPeriod) {
    if (newPeriod == null) return;
    if (newPeriod.equals(period)) return;
    period = newPeriod;

    notifyListeners();
  }

  void updateFirstDayOfTheWeek(int? newFirstDayOfTheWeek) {
    if (newFirstDayOfTheWeek == null) return;
    if (newFirstDayOfTheWeek == firstDayOfTheWeek) return;
    if (newFirstDayOfTheWeek < 1 || newFirstDayOfTheWeek > 7) return;
    _firstDayOfTheWeek = newFirstDayOfTheWeek;

    notifyListeners();
  }
}
