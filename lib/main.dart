import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/app_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appController = AppController(SettingsService());
  await appController.loadSettings();
  appController.loadTasks();
  runApp(MyApp(appController: appController));
}
