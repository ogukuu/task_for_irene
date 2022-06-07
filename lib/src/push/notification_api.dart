import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static const String channelId = "PushTaskForIreneId";
  static const String channelName = "PushTaskForIreneName";

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(channelId, channelName,
            channelDescription: 'channel for task notification',
            importance: Importance.max,
            priority: Priority.high));
  }

  Future showNotification({int id = 0, String? title, String? body}) async =>
      _flutterLocalNotificationsPlugin.show(
          id, title, body, await _notificationDetails());

  void showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          required DateTime scheduledDate,
          int secondDelay = 0}) async =>
      _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local)
            .add(Duration(seconds: secondDelay)),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  late InitializationSettings _initializationSettings;

  final AndroidInitializationSettings _initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

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
}
