
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTasks {
  final TaskRepository repo;
  AddTasks(this.repo);
  Future<void> call(Task task) => repo.addTask(task);
}