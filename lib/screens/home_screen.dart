// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
      ),
      body: const Center(
        child: Text('No tasks yet!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Will open add-task dialog later
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
