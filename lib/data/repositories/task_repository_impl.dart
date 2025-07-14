import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<List<Task>> getTasks() async {
    try {
      final models = await remote.getAllTasks();
      print('🧩 Got ${models.length} models');

      return models.map((e) {
        print('➡️ Mapping: ${e.title}');
        return Task(
          id: e.id,
          title: e.title,
          isDone: e.isDone,
          description: e.description,
          userId: e.userId,
        );
      }).toList();
    } catch (e) {
      print('❌ Error in repository.getTasks(): $e');
      return [];
    }
  }
  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      isDone: task.isDone,
      description: task.description,
      userId: task.userId,
    );
    await remote.addTask(model);
  }
}
