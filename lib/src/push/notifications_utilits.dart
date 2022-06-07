import 'package:task_for_irene/src/task/task.dart';
import 'package:task_for_irene/src/utilits/format_date.dart';

String getTitleNotification(Task task) {
  return task.title;
}

String getBodyNotification(Task task) {
  return "${getDDMMYYYY(task.dueDate)}: ${task.description}";
}
