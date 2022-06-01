import 'package:flutter/material.dart';
import 'package:task_for_irene/src/app_controller.dart';

import '../models/task.dart';

class ActiveTaskView extends StatelessWidget {
  const ActiveTaskView({Key? key, required this.controller, required this.task})
      : super(key: key);

  final AppController controller;
  final Task? task;

  @override
  Widget build(BuildContext context) {
    return const Text("active view");
  }
}
