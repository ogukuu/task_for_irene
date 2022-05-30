import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/calendar_controller.dart';
import 'package:task_for_irene/src/calendar/utilits/current_period.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  final calendarController =
      CalendarController(CurrentPeriod.now(PeriodType.month));
  runApp(MyApp(
    settingsController: settingsController,
    calendarController: calendarController,
  ));
}
