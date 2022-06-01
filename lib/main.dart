import 'package:flutter/material.dart';
import 'package:task_for_irene/src/repository/hive/hive_task_repository.dart';

import 'src/app.dart';
import 'src/app_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = HiveTaskRepository();
  await repository.init();
  final appController =
      AppController(settingsService: SettingsService(), repository: repository);
  await appController.loadSettings();
  appController.loadTasks();
  runApp(MyApp(appController: appController));
}
