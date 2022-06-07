import 'package:flutter/material.dart';

class Settings {
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode tm) {
    _themeMode = tm;
    _themeModeName = MyThemeMode.getNameThemeMode(tm);
  }

  late String _themeModeName;
  String get themeModeName => _themeModeName;
  set themeModeName(String tmn) {
    _themeModeName = tmn;
    _themeMode = MyThemeMode.getThemeMode(tmn);
  }

  Settings(
      {ThemeMode themeMode = ThemeMode.system,
      this.notificationTriggerTime = defaultNotificationTriggerTime}) {
    this.themeMode = ThemeMode.system;
  }

  Settings.byThemeModeName(
      {String themeModeName = MyThemeMode.system,
      this.notificationTriggerTime = defaultNotificationTriggerTime}) {
    this.themeModeName = themeModeName;
  }

  // Notification settings
  TimeOfDay notificationTriggerTime;

  static const TimeOfDay defaultNotificationTriggerTime =
      TimeOfDay(hour: 20, minute: 0);
}

class MyThemeMode {
  static const String system = "system";
  static const String dark = "dark";
  static const String light = "light";

  static ThemeMode get defaultThemeMode => ThemeMode.system;

  static ThemeMode getThemeMode(String nameThemeMode) {
    switch (nameThemeMode) {
      case dark:
        return ThemeMode.dark;
      case light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static String getNameThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return dark;
      case ThemeMode.light:
        return light;
      default:
        return system;
    }
  }
}
