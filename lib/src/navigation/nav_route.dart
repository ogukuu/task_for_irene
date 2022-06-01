import 'package:flutter/material.dart';
import 'package:task_for_irene/src/app_controller.dart';
import 'package:task_for_irene/src/screens/active_task_view.dart';

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

  Widget route(String? route) {
    if (route == null) {
      return CalendarView(controller: controller);
    }
    if (route.startsWith(activeTask)) {
      String id = route.replaceFirst(activeTask, ""); //no validation
      return ActiveTaskView(
          controller: controller, task: controller.getTask(id));
    }
    if (route.startsWith(comletedTask)) {
      String id = route.replaceFirst(comletedTask, ""); //no validation
      return CompletedTaskView(
          controller: controller, task: controller.getTask(id));
    }
    switch (route) {
      case addTask:
        return AddTaskView(controller: controller);
      case settings:
        return SettingsView(controller: controller);
      case tasks:
        return TasksView(controller: controller);
      case calendar:
      default:
        return CalendarView(controller: controller);
    }
  }
}
