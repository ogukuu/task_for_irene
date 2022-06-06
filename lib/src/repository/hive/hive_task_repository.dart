import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_for_irene/src/global_var.dart';
import 'package:task_for_irene/src/models/task.dart';
import 'package:task_for_irene/src/repository/task_repository.dart';

import '../../utilits/task_utilits.dart';

class HiveTaskRepository extends TaskRepository {
  String nameBox = "HiveTaskRepository";
  late Box<Task> box;

  @override
  Future<void> add(Task task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> delete(Task task) async {
    await box.delete(task.id);
  }

  @override
  List<Task> getAll() {
    return box.values.toList();
  }

  @override
  Future<void> update(Task task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> init() async {
    if (GlobalVar.hiveIsNotInit) {
      GlobalVar.hiveIsNotInit = false;
      await Hive.initFlutter();
    }
    Hive.registerAdapter(TaskAdapter());
    box = await Hive.openBox<Task>(nameBox);
    super.init();

    //Test
    await box.clear();
    for (var e in testTasks) {
      await add(e);
    }
  }

  @override
  Future<void> close() async {
    await box.compact();
    await box.close();
    super.close();
  }

  @override
  Future<void> clear() async {
    await box.clear();
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
