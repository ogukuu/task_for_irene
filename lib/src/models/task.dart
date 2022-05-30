class Task {
  int id = 0; //??
  String title;
  String description;
  DateTime dueDate;
  dynamic photoProof;
  ReminderFrequency reminderFrequency; //?
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
  static const fail = "fail";
}

var testTask = Task(
    'title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2',
    'description2',
    DateTime.now(),
    ReminderFrequency(),
    StatusTask.active,
    null);

List<Task> testTasks = [
  Task(
      'title1',
      'description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1 description1',
      DateTime.now(),
      ReminderFrequency(),
      StatusTask.active,
      null),
  Task(
      'title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2 title2',
      'description2',
      DateTime.now(),
      ReminderFrequency(),
      StatusTask.active,
      null),
  Task('title3', 'description3', DateTime.now(), ReminderFrequency(),
      StatusTask.completed, null),
  Task('title4', 'description4', DateTime.now(), ReminderFrequency(),
      StatusTask.surrender, null),
  Task('title5', 'description5', DateTime.now(), ReminderFrequency(),
      StatusTask.fail, null)
];
