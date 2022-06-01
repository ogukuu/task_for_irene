import 'package:flutter/material.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/repository/task_repository.dart';

import 'calendar/calendar_controller.dart';
import 'calendar/utilits/current_period.dart';
import 'models/task.dart';
import 'settings/settings_service.dart';

class AppController with ChangeNotifier {
  AppController({required this.settingsService, required this.repository}) {
    navRoute = NavRoute(controller: this);
  }

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

  Task? getTask(String id) {
    List<Task> t = _tasks.where((element) => element.id == id).toList();
    if (t.isEmpty) {
      return null;
    } else {
      return t.first;
    }
  }

  void clear() {
    repository.clear();
    _tasks.clear();
    notifyListeners();
  }

  // calendar controller
  final CalendarController calendarController =
      CalendarController(CurrentPeriod.now(PeriodType.month));

  // navigation
  late final NavRoute navRoute;
}
