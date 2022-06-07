import 'package:flutter/material.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/push/notification_settings.dart';
import 'package:task_for_irene/src/push/notification_api.dart';
import 'package:task_for_irene/src/push/notifications_utilits.dart';
import 'package:task_for_irene/src/task/task.dart';

class NotificationsController {
  // _______SETTINGS_______

  late NotificationSettings _settings;

  NotificationsController({NotificationSettings? settings}) {
    _settings = settings ?? NotificationSettings();
  }

  void updateSettings(NotificationSettings? settings) {
    if (settings == null) return;
    if (_settings == settings) return;
    _settings = settings;
    _rebuildingAllNotifications();
  }

  // _______NOTIFICATION API_______

  final NotificationApi _notificationApi = NotificationApi();
  NotificationApi get notificationApi => _notificationApi;

  // _______NOTIFICATION DATABASE

  int counter = 0;

  final Map<String, Notification> _notifications = {};

  final Map<String, List<int>> _ids = {};

  // _______NOTIFICATION CONTROLLER API_______

  void init() {
    _notificationApi.init();
  }

  /// to create a database of notification
  void initState({required List<Task> activeTasks}) async {
    counter = 0;
    for (var task in activeTasks) {
      await _addNotifications(task: task);
    }
    await _startAllNotification();
  }

  void addTask(Task task) async {
    if (task.isCompleted) return;
    _addNotifications(task: task);
    await _startNotificationByIdTask(idTask: task.id);
  }

  void completeTask(String idTask) {
    _stopNotificationsByIdTask(idTask: idTask);
    _notifications.remove(idTask);
    _ids.remove(idTask);
  }

  void updateTask(Task task) {
    completeTask(task.id);
    addTask(task);
  }

  // _______INTERNAL METHODS_______

  /// add list of notification to database of notification
  Future<void> _addNotifications({required Task task}) async {
    if (task.isCompleted) return;
    _notifications[task.id] = Notification(task, _settings);
    _ids[task.id] =
        List.generate(_notifications[task.id]!.dates.length, (index) {
      counter += 1;
      return counter;
    });
  }

  /// stop notification by task.id
  void _stopNotificationsByIdTask({required String idTask}) {
    if (!_notifications.containsKey(idTask)) return;
    List<int> ids = _ids[idTask]!;
    for (var id in ids) {
      _notificationApi.stopNotification(id);
    }
  }

  /// start notification by task.id
  Future<void> _startNotificationByIdTask({required String idTask}) async {
    if (!_notifications.containsKey(idTask)) return;
    Notification n = _notifications[idTask]!;
    List<int> ids = _ids[idTask]!;
    for (int i = 0; i < n.dates.length; i++) {
      _notificationApi.showScheduledNotification(
          scheduledDate: n.dates[i], title: n.title, body: n.body, id: ids[i]);
    }
  }

  /// when changing notification settings
  void _rebuildingAllNotifications() {
    _stopAllNotification();
    _buildAllNotification();
  }

  /// stop all notification
  void _stopAllNotification() {
    _notificationApi.stopAllNotification();
  }

  /// recreating the database of notifications
  void _buildAllNotification() {
    initState(activeTasks: GlobalVar.appController.activeTasks);
  }

  /// start all notification
  Future<void> _startAllNotification() async {
    for (var id in _notifications.keys) {
      Notification n = _notifications[id]!;
      List<int> ids = _ids[id]!;
      for (int i = 0; i < n.dates.length; i++) {
        _notificationApi.showScheduledNotification(
            scheduledDate: n.dates[i],
            title: n.title,
            body: n.body,
            id: ids[i]);
      }
    }
  }
}

class Notification {
  late final String title;
  late final String body;
  final List<DateTime> dates = [];
  Notification(Task task, NotificationSettings settings) {
    title = getTitleNotification(task);
    body = getBodyNotification(task);
    TimeOfDay time = settings.notificationTime;
    DateTime dueDate = task.dueDate;
    DateTime day = DateTime(
            dueDate.year, dueDate.month, dueDate.day, time.hour, time.minute)
        .subtract(const Duration(days: 1));
    switch (task.reminderFrequency) {
      case ReminderFrequency.day:
        {
          while (day.isAfter(DateTime.now())) {
            dates.add(day);
            day = day.subtract(const Duration(days: 1));
          }
          break;
        }
      case ReminderFrequency.week:
        {
          while (day.isAfter(DateTime.now())) {
            dates.add(day);
            day = day.subtract(const Duration(days: 7));
          }
          break;
        }
      case ReminderFrequency.month:
        {
          while (day.isAfter(DateTime.now())) {
            dates.add(day);
            day = DateTime(day.year, CalendarUtilits.prevMonth(day.month),
                day.day, day.hour, day.minute);
          }
          break;
        }
    }
  }
}
