import 'package:flutter/material.dart';
import 'package:task_for_irene/src/repository/task_repository.dart';

import 'calendar/calendar_controller.dart';
import 'calendar/utilits/current_period.dart';
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

  Brightness getCurrentBrightness(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
        return (MediaQuery.of(context).platformBrightness == Brightness.light)
            ? Brightness.light
            : Brightness.dark;
    }
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

  List<Task> getTasksAtId(String id) {
    return _tasks.where((element) => element.id == id).toList();
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

  void deleteTaskAtId(String id) {
    var idTasks = _tasks.where((element) => element.id == id);
    if (idTasks.isEmpty) return;
    Task deletedTask = idTasks.first;
    deleteTask(deletedTask);
  }

  void surrenderTask(Task task) {
    task.surrender();
    repository.update(task);
    notifyListeners();
  }

  void surrenderTaskAtId(String id) {
    var idTasks = _tasks.where((element) => element.id == id);
    if (idTasks.isEmpty) return;
    Task surrendedTask = idTasks.first;
    surrenderTask(surrendedTask);
  }

  void update(Task task) {
    _tasks.removeWhere((element) => element.id == task.id);
    _tasks.add(task);
    repository.update(task);
    notifyListeners();
  }

  bool isNotCorrect(String id) => getTasksAtId(id).isEmpty;

  void proofTask(String id, dynamic proof) {
    if (proof == null) return;
    if (isNotCorrect(id)) return;
    var task = getTasksAtId(id).first;
    if (task.isCompleted) return;
    task.success(proof);
    update(task);
  }

  List<Task> taskForThisYear(DateTime dateTime) =>
      _tasks.where((element) => element.isAtThisYear(dateTime)).toList();

  List<Task> taskForThisMonth(DateTime dateTime) =>
      _tasks.where((element) => element.isAtThisMonth(dateTime)).toList();

  List<Task> taskForThisDay(DateTime dateTime) =>
      _tasks.where((element) => element.isAtThisDay(dateTime)).toList();

  List<Task> taskForThisHour(DateTime dateTime) =>
      _tasks.where((element) => element.isAtThisHour(dateTime)).toList();

  bool isTaskForThisYear(DateTime dateTime) =>
      taskForThisYear(dateTime).isNotEmpty;

  bool isTaskForThisMonth(DateTime dateTime) =>
      taskForThisMonth(dateTime).isNotEmpty;

  bool isTaskForThisDay(DateTime dateTime) =>
      taskForThisDay(dateTime).isNotEmpty;

  bool isTaskForThisHour(DateTime dateTime) =>
      taskForThisHour(dateTime).isNotEmpty;

  // calendar controller
  final CalendarController calendarController =
      CalendarController(CurrentPeriod.now(PeriodType.month));
}
