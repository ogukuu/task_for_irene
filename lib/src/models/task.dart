import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_for_irene/src/utilits/uuid.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  dynamic photoProof;
  String reminderFrequency;
  String status;

  bool get isActive => status == StatusTask.active;
  bool get isCompleted => !isActive;
  bool isAtThisYear(DateTime dateTime) => dueDate.year == dateTime.year;
  bool isAtThisMonth(DateTime dateTime) =>
      isAtThisYear(dateTime) && (dueDate.month == dateTime.month);
  bool isAtThisDay(DateTime dateTime) =>
      isAtThisMonth(dateTime) && (dueDate.day == dateTime.day);
  bool isAtThisHour(DateTime dateTime) =>
      isAtThisDay(dateTime) && (dueDate.hour == dateTime.hour);

  Task(this.id, this.title, this.description, this.dueDate,
      this.reminderFrequency, this.status, this.photoProof);

  Task.newTask(String title, String description, DateTime dueDate,
      String reminderFrequency)
      : this(UUID.getNew, title, description, dueDate, reminderFrequency,
            StatusTask.active, null);

  void success(dynamic proof) {
    photoProof = proof;
    status = StatusTask.success;
  }

  void surrender() {
    status = StatusTask.surrendered;
  }

  void fail() {
    status = StatusTask.fail;
  }

  String testDescription() {
    return "id: $id, status:$status, freq:$reminderFrequency, dueDate: ${dueDate.toString()}";
  }

  @override
  bool operator ==(Object other) => other is Task && other.id == id;

  @override
  int get hashCode => id.hashCode;

  void testDueDate() {
    if (status == StatusTask.active && dueDate.isBefore(DateTime.now())) fail();
  }

  Task getCopy() {
    return Task(
        id, title, description, dueDate, reminderFrequency, status, photoProof);
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
  // static const completed = "completed";
  static const surrendered = "surrendered";
  static const fail = "fail";
  static const success = "success";
}
