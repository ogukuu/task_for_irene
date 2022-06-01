import 'package:flutter/material.dart';

import '../app_controller.dart';
import '../models/task.dart';

class CompletedTaskView extends StatelessWidget {
  const CompletedTaskView(
      {Key? key, required this.controller, required this.task})
      : super(key: key);

  final AppController controller;
  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
