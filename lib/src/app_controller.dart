import 'package:flutter/material.dart';

import 'models/task.dart';
import 'settings/settings_service.dart';

class AppController with ChangeNotifier {
  AppController(this._settingsService);
  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  // test controller
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void loadTasks() {
    _tasks.addAll(testTasks);

    notifyListeners();
  }

  void addTask(Task? task) {
    if (task == null) return;
    if (_tasks.contains(task)) return;
    _tasks.add(task);
    notifyListeners();
  }
}
