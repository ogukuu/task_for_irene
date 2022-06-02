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
  List<Task> get tasks => List.of(_tasks, growable: false);
  List<Task> get activeTasks =>
      List.of(_tasks.where((element) => element.isActive), growable: false)
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

  List<Task> get completedTasks =>
      List.of(_tasks.where((element) => element.isCompleted), growable: false)
        ..sort((a, b) => b.dueDate.compareTo(a.dueDate));

  void loadTasks() {
    _tasks.addAll(repository.getAll());
    for (var element in _tasks) {
      element.testDueDate();
    }
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

  void deleteTask(Task task) {
    _tasks.remove(task);
    repository.delete(task);
    notifyListeners();
  }

  void surrenderTask(Task task) {
    task.surrender();
    repository.update(task);
    notifyListeners();
  }

  // calendar controller
  final CalendarController calendarController =
      CalendarController(CurrentPeriod.now(PeriodType.month));

  // navigation
  late final NavRoute navRoute;
}
