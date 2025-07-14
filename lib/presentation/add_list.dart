import 'package:flutter/material.dart';
import '../domain/entities/task.dart';
import '../domain/use cases/add_tasks.dart';

class AddList extends StatefulWidget {
  final AddTasks addTask;
  const AddList({super.key, required this.addTask});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add List')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
              // TextFormField(
              //   decoration: InputDecoration(border: OutlineInputBorder()),
              // ),
              ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();
                  if (title.isNotEmpty && description.isNotEmpty) {
                    widget.addTask(
                      Task(
                        description: description,
                        id: '',
                        title: title,
                        isDone: false,
                        userId: '',
                      ),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Task Added')));
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
