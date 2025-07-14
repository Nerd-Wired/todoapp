import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'Presentation/home_screen.dart';
import 'data/datasources/task_remote_data_source.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/use cases/add_tasks.dart';
import 'domain/use cases/get_tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  const deviceIdKey = 'device_id';
  String? deviceId = prefs.getString(deviceIdKey);

  if (deviceId == null) {
    deviceId = const Uuid().v4();
    await prefs.setString(deviceIdKey, deviceId);
    print('🆕 Device ID generated: $deviceId');
  } else {
    print('🔁 Device ID exists: $deviceId');
  }
  await Supabase.initialize(
    url: 'https://ddjgnkoiqapfcgxucqdm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRkamdua29pcWFwZmNneHVjcWRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI0Nzk3NDMsImV4cCI6MjA2ODA1NTc0M30.1xRvRIKMwQJ3_DRcSI-WlYZYJ0RoWpWEE02tOyNIcTE',
  );

  final client = Supabase.instance.client;

  final dataSource = TaskRemoteDataSourceImpl(client, deviceId);
  final repository = TaskRepositoryImpl(dataSource);
  final getTasks = GetTasks(repository);
  final addTasks = AddTasks(repository);

  runApp(MyApp(getTasks: getTasks, addTasks: addTasks));
}

class MyApp extends StatelessWidget {
  final GetTasks getTasks;
  final AddTasks addTasks;

  const MyApp({super.key, required this.getTasks, required this.addTasks});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(getTasks: getTasks, addTasks: addTasks));
  }
}
