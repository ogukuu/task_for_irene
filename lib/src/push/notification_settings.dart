import 'package:flutter/material.dart';

class NotificationSettings {
  NotificationSettings();
  TimeOfDay alertTime = const TimeOfDay(hour: 19, minute: 00);
  bool dispersion = false;

  ///dispersion value in seconds
  int dispersionValue = 15;
}
