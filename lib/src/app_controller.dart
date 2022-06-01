import 'package:flutter/material.dart';
import 'package:task_for_irene/src/repository/task_repository.dart';

import 'models/task.dart';
import 'settings/settings_service.dart';

class AppController with ChangeNotifier {
  AppController({required this.settingsService, required this.repository});

  //setting controller

  final SettingsService settingsService;
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await settingsService.themeMode();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await settingsService.updateThemeMode(newThemeMode);
  }

  // task controller
  final TaskRepository repository;

  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void loadTasks() {
    //_tasks.addAll(testTasks);
    _tasks.addAll(repository.getAll());
    notifyListeners();
  }

  void addTask(Task? task) {
    if (task == null) return;
    if (_tasks.contains(task)) return;
    _tasks.add(task);
    repository.add(task);
    notifyListeners();
  }
}
