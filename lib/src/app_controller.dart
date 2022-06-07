import 'package:flutter/material.dart';
import 'package:task_for_irene/src/push/notifications_controller.dart';
import 'package:task_for_irene/src/push/notification_api.dart';
import 'package:task_for_irene/src/repository/settings_repository.dart';
import 'package:task_for_irene/src/repository/task_repository.dart';
import 'package:task_for_irene/src/settings/settings.dart';
import 'package:task_for_irene/src/task/task.dart';

import 'calendar/calendar_controller.dart';
import 'calendar/utilits/current_period.dart';

class AppController with ChangeNotifier {
  AppController({required this.settingsRepository, required this.repository});

  //setting controller

  final SettingsRepository settingsRepository;
  late Settings _settings;
  Settings get settings => _settings;
  ThemeMode get themeMode => _settings.themeMode;

  void loadSettings() {
    _settings = settingsRepository.read();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _settings.themeMode) return;

    _settings.themeMode = newThemeMode;

    await settingsRepository.write(_settings);

    notifyListeners();
  }

  Brightness getCurrentBrightness(BuildContext context) {
    switch (_settings.themeMode) {
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
    if (task.isCompleted) return;
    if (_tasks.contains(task)) return;
    _tasks.add(task);
    repository.add(task);
    notificationsController.addTask(task);
    notifyListeners();
  }

  List<Task> getTasksAtId(String id) {
    return _tasks.where((element) => element.id == id).toList();
  }

  void clear() {
    repository.clear();
    _tasks.clear();
    notificationsController.initState(activeTasks: []);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    repository.delete(task);
    notificationsController.completeTask(task.id);
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
    notificationsController.completeTask(task.id);
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
    notificationsController.updateTask(task);
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

  List<Task> taskForThisYear(DateTime dateTime) => _tasks
      .where((element) => element.isAtThisYear(dateTime) && element.isActive)
      .toList();

  List<Task> taskForThisMonth(DateTime dateTime) => _tasks
      .where((element) => element.isAtThisMonth(dateTime) && element.isActive)
      .toList();

  List<Task> taskForThisDay(DateTime dateTime) => _tasks
      .where((element) => element.isAtThisDay(dateTime) && element.isActive)
      .toList();

  List<Task> taskForThisHour(DateTime dateTime) => _tasks
      .where((element) => element.isAtThisHour(dateTime) && element.isActive)
      .toList();

  bool isTaskForThisYear(DateTime dateTime) =>
      taskForThisYear(dateTime).isNotEmpty;

  bool isTaskForThisMonth(DateTime dateTime) =>
      taskForThisMonth(dateTime).isNotEmpty;

  bool isTaskForThisDay(DateTime dateTime) =>
      taskForThisDay(dateTime).isNotEmpty;

  bool isTaskForThisHour(DateTime dateTime) =>
      taskForThisHour(dateTime).isNotEmpty;

  // calendar controller

  int get firstDayOfTheWeek => calendarController.firstDayOfTheWeek;
  set firstDayOfTheWeek(int day) =>
      calendarController.updateFirstDayOfTheWeek(day);

  final CalendarController calendarController =
      CalendarController(CurrentPeriod.now(PeriodType.month));

  // NotificationsController

  final NotificationsController notificationsController =
      NotificationsController();
  NotificationApi get push => notificationsController.notificationApi;

  void initNotifications() {
    notificationsController.init();
    notificationsController.initState(activeTasks: activeTasks);
  }
}
