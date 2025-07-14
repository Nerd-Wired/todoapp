import 'package:flutter/material.dart';
import 'package:todo1/Presentation/view_list.dart';
import 'package:todo1/presentation/add_list.dart';

class HomeScreen extends StatelessWidget {
  final dynamic getTasks;
  final dynamic addTasks;
  const HomeScreen({super.key, required this.addTasks,required this.getTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text('Add List'),
              tileColor: Colors.black12,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddList(addTask: addTasks),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            ListTile(
              tileColor: Colors.black12,
              title: Text('View List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewList(getTasks: getTasks),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
