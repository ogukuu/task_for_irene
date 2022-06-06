import 'package:flutter/material.dart';

class Settings {
  late ThemeMode themeMode;
  late String themeModeName;
  Settings() {
    themeMode = ThemeMode.system;
    themeModeName = MyThemeMode.getNameThemeMode(themeMode);
  }

  Settings.byName({this.themeModeName = MyThemeMode.system}) {
    themeMode = MyThemeMode.getThemeMode(themeModeName);
  }

  Settings byThemeMode(ThemeMode themeMode) {
    return Settings.byName(
        themeModeName: MyThemeMode.getNameThemeMode(themeMode));
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
