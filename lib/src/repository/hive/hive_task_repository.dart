import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_for_irene/src/models/task.dart';
import 'package:task_for_irene/src/repository/task_repository.dart';

class HiveTaskRepository extends TaskRepository {
  String nameBox = "HiveTaskRepository";
  late Box<Task> box;

  @override
  void add(Task task) async {
    await box.put(task.id, task);
  }

  @override
  void delete(Task task) async {
    await box.delete(task.id);
  }

  @override
  List<Task> getAll() {
    return box.values.toList();
  }

  @override
  void update(Task task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter(); //??? settings!!!
    Hive.registerAdapter(TaskAdapter());
    box = await Hive.openBox<Task>(nameBox);
    super.init();
  }

  @override
  void close() {
    box.close();
    super.close();
  }

  @override
  void clear() {
    box.clear();
    super.clear();
  }
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  Task read(BinaryReader reader) {
    var id = reader.readString();
    var title = reader.readString();
    var description = reader.readString();
    DateTime dueDate = reader.read();
    var reminderFrequency = reader.readString();
    var status = reader.readString();
    dynamic photoProof = reader.read();
    return Task(
        id, title, description, dueDate, reminderFrequency, status, photoProof);
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.write(obj.dueDate);
    writer.writeString(obj.reminderFrequency);
    writer.writeString(obj.status);
    writer.write(obj.photoProof);
  }
}
