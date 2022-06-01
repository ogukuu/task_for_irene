import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/app_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final appController = AppController(SettingsService());
  await appController.loadSettings();
  appController.loadTasks();
  runApp(MyApp(appController: appController));
}
