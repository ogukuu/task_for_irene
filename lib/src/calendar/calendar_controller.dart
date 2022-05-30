import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

class CalendarController extends ChangeNotifier {
  CurrentPeriod _period;
  CurrentPeriod get period => _period;

  CalendarController(this._period);

  Future<void> updatePeriodType(CurrentPeriod? newPeriod) async {
    if (newPeriod == null) return;

    if (newPeriod == _period) return;

    _period = newPeriod;

    notifyListeners();
  }
}
