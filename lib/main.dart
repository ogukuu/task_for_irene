import 'package:flutter/material.dart';
import 'package:task_for_irene/src/global_var.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVar.appController.repository.init();
  await GlobalVar.appController.settingsService.init();
  await GlobalVar.appController.loadSettings();
  GlobalVar.appController.loadTasks();
  runApp(MyApp(appController: GlobalVar.appController));
}
