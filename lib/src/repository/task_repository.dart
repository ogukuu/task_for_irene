import '../models/task.dart';

abstract class TaskRepository {
  List<Task> getAll();
  void add(Task task);
  void delete(Task task);
  void update(Task task);
  Future<void> init() async {}
  Future<void> close() async {}
  Future<void> clear() async {}
}
