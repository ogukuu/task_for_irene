import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static const String channelId = "PushTaskForIreneId";
  static const String channelName = "PushTaskForIreneName";
  static const String channelDescription = "channelDescription";

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const NotificationDetails _notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(channelId, channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high));

  Future<void> showNotification(
          {int id = 0, String? title, String? body}) async =>
      await _flutterLocalNotificationsPlugin.show(
          id, title, body, _notificationDetails);

  Future<void> showScheduledNotification(
          {required int id,
          required String title,
          required String body,
          required DateTime dueDate,
          String? payload}) async =>
      await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
          tz.TZDateTime.from(dueDate, tz.local), _notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload);

  late InitializationSettings _initializationSettings;

  final AndroidInitializationSettings _initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/notification2');

  void init() {
    _initializationSettings =
        InitializationSettings(android: _initializationSettingsAndroid);
    _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
    tz.initializeTimeZones();
  }

  void stopNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  void stopAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  //void onSelectNotification(String? payload) {}

  /// Daily
  Future<void> scheduleDailyNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime dueDate,
      String? payload}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        _nextInstanceOfDaily(dueDate: dueDate), _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload);
  }

  tz.TZDateTime _nextInstanceOfDaily({required DateTime dueDate}) {
    final DateTime now = DateTime.now();
    DateTime scheduledDate =
        DateTime(now.year, now.month, now.day, dueDate.hour, dueDate.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return tz.TZDateTime.from(scheduledDate, tz.local);
  }

  /// Weekly
  Future<void> scheduleWeeklyNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime dueDate,
      String? payload}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        _nextInstanceOfWeekly(dueDate: dueDate), _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: payload);
  }

  tz.TZDateTime _nextInstanceOfWeekly({required DateTime dueDate}) {
    final int dayOfTheWeek = dueDate.subtract(const Duration(days: 1)).weekday;
    final DateTime now = DateTime.now();
    DateTime scheduledDate =
        DateTime(now.year, now.month, now.day, dueDate.hour, dueDate.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    while (scheduledDate.weekday != dayOfTheWeek) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return tz.TZDateTime.from(scheduledDate, tz.local);
  }

  /// Monthly not work
  Future<void> scheduleMonthlyNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime dueDate,
      String? payload}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        _nextInstanceOfMonthly(dueDate: dueDate), _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
        payload: payload);
  }

  tz.TZDateTime _nextInstanceOfMonthly({required DateTime dueDate}) {
    final int dayOfTheWeek = dueDate.subtract(const Duration(days: 1)).weekday;
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, dueDate.hour, dueDate.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    while (scheduledDate.weekday != dayOfTheWeek) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<List<PendingNotificationRequest>> get allActiveNotification =>
      _flutterLocalNotificationsPlugin.pendingNotificationRequests();
}
