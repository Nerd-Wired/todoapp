import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';

abstract class  TaskRemoteDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final SupabaseClient client;
  final String  userId;

  TaskRemoteDataSourceImpl(this.client, this.userId);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final response = await client.from('tasks').select().eq('user_id', userId);

    List<TaskModel> tasks =(response as List)
        .map((json) => TaskModel.fromMap(json))
        .toList();

    return tasks;
  }
  @override
  Future<void> addTask(TaskModel task) async {
    await client.from('tasks').insert(task.toMap(userId)).select();

  }

}