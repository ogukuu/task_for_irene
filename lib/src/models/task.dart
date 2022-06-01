import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Task {
  int id = 0; //??
  String title;
  String description;
  DateTime dueDate;
  dynamic photoProof;
  String reminderFrequency;
  String status;

  Task(this.id, this.title, this.description, this.dueDate,
      this.reminderFrequency, this.status, this.photoProof);

  Task.newTask(String title, String description, DateTime dueDate,
      String reminderFrequency)
      : this(0, title, description, dueDate, reminderFrequency,
            StatusTask.active, null);

  void completed(dynamic proof) {
    photoProof = proof;
    status = StatusTask.completed;
  }

  void surrender() {
    status = StatusTask.surrendered;
  }
}

class ReminderFrequency {
  static const day = "day";
  static const week = "week";
  static const month = "month";
  static getText(BuildContext context, String freq) {
    switch (freq) {
      case ReminderFrequency.day:
        return AppLocalizations.of(context)!.reminderFrequencyDay;
      case ReminderFrequency.month:
        return AppLocalizations.of(context)!.reminderFrequencyMonth;
      case ReminderFrequency.week:
        return AppLocalizations.of(context)!.reminderFrequencyWeek;
      default:
        return "";
    }
  }
}

class StatusTask {
  static const active = "active";
  static const completed = "completed";
  static const surrendered = "surrendered";
  static const fail = "fail";
}

var testTask = Task(
    0,
    'title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2',
    'description2',
    DateTime.now(),
    ReminderFrequency.day,
    StatusTask.active,
    null);

List<Task> testTasks = [
  Task(
      0,
      'title1',
      'description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1',
      DateTime.now(),
      ReminderFrequency.week,
      StatusTask.active,
      null),
  Task(
      0,
      'title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2',
      'description2',
      DateTime.now(),
      ReminderFrequency.month,
      StatusTask.active,
      null),
  Task(0, 'title3', 'description3', DateTime.now(), ReminderFrequency.day,
      StatusTask.completed, null),
  Task(0, 'title4', 'description4', DateTime.now(), ReminderFrequency.month,
      StatusTask.surrendered, null),
  Task(0, 'title5', 'description5', DateTime.now(), ReminderFrequency.week,
      StatusTask.fail, null)
];
