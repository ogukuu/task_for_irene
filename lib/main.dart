import 'package:flutter/material.dart';
import 'package:task_for_irene/src/global_var.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVar.appController.repository.init();
  await GlobalVar.appController.settingsRepository.init();
  GlobalVar.appController.loadSettings();
  GlobalVar.appController.loadTasks();
  runApp(const _InitApp());
}

class _InitApp extends StatefulWidget {
  const _InitApp({Key? key}) : super(key: key);

  @override
  State<_InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<_InitApp> {
  @override
  void dispose() {
    GlobalVar.appController.repository.close();
    GlobalVar.appController.settingsRepository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
