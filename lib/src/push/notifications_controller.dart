import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/push/notification_api.dart';
import 'package:task_for_irene/src/push/notifications_utilits.dart';
import 'package:task_for_irene/src/task/task.dart';
import 'package:task_for_irene/src/calendar/utilits/calendar_utilits.dart';

class NotificationsController {
  // _______SETTINGS_______

  late TimeOfDay _notificationTriggerTime;

  NotificationsController({required TimeOfDay notificationTriggerTime}) {
    _notificationTriggerTime = notificationTriggerTime;
  }

  void updateSettings(TimeOfDay? newNotificationTriggerTime) {
    if (newNotificationTriggerTime == null) return;
    if (_notificationTriggerTime == newNotificationTriggerTime) return;
    _notificationTriggerTime = newNotificationTriggerTime;
    _rebuildingAllNotifications();
  }

  // _______NOTIFICATION API_______

  final NotificationApi _notificationApi = NotificationApi();
  NotificationApi get notificationApi => _notificationApi;

  // _______NOTIFICATION DATABASE

  int counter = 1;

  final Map<String, Notification> _notifications = {};

  // _______NOTIFICATION CONTROLLER API_______

  void init() {
    _notificationApi.init();
  }

  /// to create a database of notification
  void initState({required List<Task> activeTasks}) async {
    counter = 1;
    //_stopAllNotification();
    List<PendingNotificationRequest> allActiveNotification =
        await _notificationApi.allActiveNotification;
    if (allActiveNotification.isNotEmpty) {
      _stopAllNotification();
    }
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
  }

  void updateTask(Task task) {
    completeTask(task.id);
    addTask(task);
  }

  // _______INTERNAL METHODS_______

  /// add list of notification to database of notification
  Future<void> _addNotifications({required Task task}) async {
    if (task.isCompleted) return;
    _notifications[task.id] = Notification(task, _notificationTriggerTime);
    _notifications[task.id]!.id = counter;
    counter++;
    if (_notifications[task.id]!.reminderFrequency == ReminderFrequency.month) {
      _notifications[task.id]!.addId = counter;
      counter++;
    }
  }

  /// stop notification by task.id
  void _stopNotificationsByIdTask({required String idTask}) {
    if (!_notifications.containsKey(idTask)) return;
    _notificationApi.stopNotification(_notifications[idTask]!.id);
    if (_notifications[idTask]!.id != _notifications[idTask]!.addId) {
      _notificationApi.stopNotification(_notifications[idTask]!.addId);
    }
  }

  /// start notification by task.id
  Future<void> _startNotificationByIdTask({required String idTask}) async {
    if (!_notifications.containsKey(idTask)) return;
    Notification n = _notifications[idTask]!;
    switch (n.reminderFrequency) {
      case ReminderFrequency.day:
        await _notificationApi.scheduleDailyNotification(
            id: n.id, title: n.title, body: n.body, dueDate: n.dueDate);
        break;
      case ReminderFrequency.week:
        await _notificationApi.scheduleWeeklyNotification(
            id: n.id, title: n.title, body: n.body, dueDate: n.dueDate);
        break;
      case ReminderFrequency.month:
        if (_getFirstDateMonthly(n.dueDate).isAfter(DateTime.now())) {
          await _notificationApi.showScheduledNotification(
              id: n.id,
              title: n.title,
              body: n.body,
              dueDate: _getFirstDateMonthly(n.dueDate));
        }
        if (_getSecondDateMonthly(n.dueDate).isAfter(DateTime.now())) {
          await _notificationApi.showScheduledNotification(
              id: n.addId,
              title: n.title,
              body: n.body,
              dueDate: _getSecondDateMonthly(n.dueDate));
        }
        break;
    }
  }

  DateTime _getFirstDateMonthly(DateTime dueDate) {
    final List<DateTime> dates = [];
    DateTime tempDay = dueDate.subtract(const Duration(days: 1));
    final DateTime now = DateTime.now();
    while (tempDay.isAfter(now)) {
      dates.add(tempDay);
      tempDay = DateTime(tempDay.year, CalendarUtilits.prevMonth(tempDay.month),
          tempDay.day, tempDay.hour, tempDay.minute);
    }
    return (dates.isNotEmpty)
        ? dates.last
        : now.subtract(const Duration(days: 1));
  }

  DateTime _getSecondDateMonthly(DateTime dueDate) {
    final List<DateTime> dates = [];
    DateTime tempDay = dueDate.subtract(const Duration(days: 1));
    final DateTime now = DateTime.now();
    while (tempDay.isAfter(now)) {
      dates.add(tempDay);
      tempDay = DateTime(tempDay.year, CalendarUtilits.prevMonth(tempDay.month),
          tempDay.day, tempDay.hour, tempDay.minute);
    }
    if ((dates.isNotEmpty) && (dates.length > 2)) {
      return dates[dates.length - 2];
    }
    return now.subtract(const Duration(days: 1));
  }

  /// when changing notification settings
  void _rebuildingAllNotifications() {
    _stopAllNotification();
    _buildAllNotification();
  }

  /// stop all notification
  void _stopAllNotification() {
    //_notificationApi.stopAllNotification();
    for (var e in _notifications.keys) {
      _stopNotificationsByIdTask(idTask: e);
    }
  }

  /// recreating the database of notifications
  void _buildAllNotification() {
    initState(activeTasks: GlobalVar.appController.activeTasks);
  }

  /// start all notification
  Future<void> _startAllNotification() async {
    for (var id in _notifications.keys) {
      _startNotificationByIdTask(idTask: id);
    }
  }
}

class Notification {
  late final String title;
  late final String body;
  late final DateTime dueDate;
  late final String reminderFrequency;
  int _id = 0;
  int get id => _id;
  set id(int i) => {
        _id = i,
        if (addId == 0) {addId = i}
      };
  int addId = 0;

  Notification(Task task, TimeOfDay notificationTriggerTime) {
    title = getTitleNotification(task);
    body = getBodyNotification(task);
    dueDate = DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day,
        notificationTriggerTime.hour, notificationTriggerTime.minute);
    reminderFrequency = task.reminderFrequency;
  }
}
