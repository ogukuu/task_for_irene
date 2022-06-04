import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/repository/hive/hive_task_repository.dart';
import 'package:task_for_irene/src/settings/settings_service.dart';

class GlobalVar {
  static final AppController appController = AppController(
      settingsService: SettingsService(), repository: HiveTaskRepository());

  static final NavRoute navRoute = NavRoute();
}
