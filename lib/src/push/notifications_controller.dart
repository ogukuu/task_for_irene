import 'package:task_for_irene/src/push/notification_settings.dart';
import 'package:task_for_irene/src/task/task.dart';

class NotificationsController {
  late NotificationSettings _settings;

  NotificationsController({NotificationSettings? settings}) {
    _settings = settings ?? NotificationSettings();
  }

  void updateSettings(NotificationSettings? settings) {
    if (settings == null) return;
    if (_settings == settings) return;
  }

  void addNotifications(Task task) {}

  void stopNotifications(String id) {}
}
