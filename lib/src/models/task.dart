class Task {
  String title;
  String description;
  DateTime dueDate;
  dynamic photoProof;
  ReminderFrequency reminderFrequency;
  String status;

  Task(this.title, this.description, this.dueDate, this.reminderFrequency,
      this.status, this.photoProof);

  Task.newTask(String title, String description, DateTime dueDate,
      ReminderFrequency reminderFrequency)
      : this(title, description, dueDate, reminderFrequency, StatusTask.active,
            null);

  void completed(dynamic proof) {
    photoProof = proof;
    status = StatusTask.completed;
  }

  void surrender() {
    status = StatusTask.surrender;
  }
}

class ReminderFrequency {}

class StatusTask {
  static const active = "active";
  static const completed = "completed";
  static const surrender = "surrender";
}
