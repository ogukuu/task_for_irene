import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/navigation/nav_route.dart';
import 'package:task_for_irene/src/repository/hive/hive_settings_repository.dart';
import 'package:task_for_irene/src/repository/hive/hive_task_repository.dart';

class GlobalVar {
  static final AppController appController = AppController(
      settingsRepository: HiveSettingsRepository(),
      repository: HiveTaskRepository());

  static final NavRoute navRoute = NavRoute();

  static const double goldenRatio = 1.62;

  static bool hiveIsNotInit = true;
}
