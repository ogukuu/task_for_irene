import 'package:flutter/material.dart';

class NotificationSettings {
  NotificationSettings();
  TimeOfDay notificationTime = const TimeOfDay(hour: 20, minute: 00);

  @override
  bool operator ==(Object other) =>
      other is NotificationSettings &&
      other.notificationTime == notificationTime;

  @override
  int get hashCode => notificationTime.hashCode;
}
