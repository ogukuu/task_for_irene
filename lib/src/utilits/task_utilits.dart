import 'package:flutter/material.dart';
import 'package:task_for_irene/src/utilits/uuid.dart';

import '../models/task.dart';

Widget getStatusImage(Task task) {
  switch (task.status) {
    case StatusTask.fail:
      return Image.asset('assets/images/fail.png');
    case StatusTask.surrendered:
      return Image.asset('assets/images/surrendered.png');
    case StatusTask.completed:
      return task.photoProof ??
          Image.asset('assets/images/error_not_found_proof.png');
    default:
      return Image.asset('assets/images/error.png');
  }
}

var testTask = Task(
    UUID.getNew,
    'title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2',
    'description2',
    DateTime.now(),
    ReminderFrequency.day,
    StatusTask.active,
    null);

List<Task> testTasks = [
  Task(
      UUID.getNew,
      'title1',
      'description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1',
      DateTime(2002),
      ReminderFrequency.week,
      StatusTask.active,
      null),
  Task(
      UUID.getNew,
      'title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2',
      'description2',
      DateTime(2030),
      ReminderFrequency.month,
      StatusTask.active,
      null),
  Task(UUID.getNew, 'title3', 'description3', DateTime(2025),
      ReminderFrequency.day, StatusTask.completed, null),
  Task(UUID.getNew, 'title4', 'description4', DateTime(2020),
      ReminderFrequency.month, StatusTask.surrendered, null),
  Task(UUID.getNew, 'title5', 'description5', DateTime(2023),
      ReminderFrequency.week, StatusTask.fail, null)
];
