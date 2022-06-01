import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsService {
  static String settingsBoxName = "settingsBoxName";
  static String themeModeSettingKey = "themeModeSettingKey";
  final Future<Box<String>> _settingsBox =
      Hive.openBox<String>(settingsBoxName);

  Future<ThemeMode> themeMode() async {
    var settingsBox = await _settingsBox;
    return MyThemeMode.getThemeMode(
        settingsBox.get(themeModeSettingKey) ?? MyThemeMode.system);
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    var settingsBox = await _settingsBox;
    settingsBox.put(themeModeSettingKey, MyThemeMode.getNameThemeMode(theme));
  }
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
