import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future showNotification(
        {int id = 0, String? title, String? body, String? payload}) async =>
    flutterLocalNotificationsPlugin
        .show(id, title, body, await _notificationDetails(), payload: payload);

Future _notificationDetails() async {
  return const NotificationDetails(
      android: AndroidNotificationDetails(
    'your channel id', 'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    //ticker: 'ticker'
  ));
}

final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

void showScheduledNotification(
        {int id = 0,
        String? title,
        String? body,
        String? payload,
        required DateTime scheduledDate,
        int secondDelay = 0}) async =>
    flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local)
            .add(Duration(seconds: secondDelay)),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
        matchDateTimeComponents: DateTimeComponents.time);
