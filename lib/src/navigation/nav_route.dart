import 'package:flutter/material.dart';
import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/models/task.dart';
import 'package:task_for_irene/src/screens/active_task_view.dart';
import 'package:task_for_irene/src/screens/error_view.dart';

import '../screens/add_task_view.dart';
import '../screens/calendar_view.dart';
import '../screens/completed_task_view.dart';
import '../screens/tasks_view.dart';
import '../settings/settings_view.dart';

class NavRoute {
  NavRoute({required this.controller});
  AppController controller;

  static const addTask = "/add_task";
  static const settings = "/settings";
  static const calendar = "/calendar";
  static const tasks = "/tasks";
  static const activeTask = "/active_task?id=";
  static const comletedTask = "/completed_task?id=";
  static const error = "/error";

  Widget route(String? route) {
    if (route == null) {
      return const ErrorView();
    }
    if (route.startsWith(activeTask)) {
      String id = route.replaceFirst(activeTask, "");
      List<Task> tasks = controller.getTasksAtId(id); //no validation
      if (tasks.isEmpty) return const ErrorView();
      return ActiveTaskView(task: tasks.first);
    }
    if (route.startsWith(comletedTask)) {
      String id = route.replaceFirst(comletedTask, ""); //no validation
      List<Task> tasks = controller.getTasksAtId(id);
      if (tasks.isEmpty) return const ErrorView();
      return CompletedTaskView(task: tasks.first);
    }
    switch (route) {
      case addTask:
        return AddTaskView(controller: controller);
      case settings:
        return SettingsView(controller: controller);
      case tasks:
        return TasksView(controller: controller);
      case error:
        return const ErrorView();
      case calendar:
      default:
        return CalendarView(controller: controller);
    }
  }
}
