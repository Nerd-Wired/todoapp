import 'package:flutter/material.dart';
import '../domain/use cases/get_tasks.dart';
import '../domain/entities/task.dart';

class ViewList extends StatefulWidget {
  final GetTasks getTasks;
  const ViewList({super.key, required this.getTasks});

  @override
  State<ViewList> createState() => _ViewListState();
}


class _ViewListState extends State<ViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My To-Do List')),
      body: FutureBuilder<List<Task>>(
        future: widget.getTasks(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data ?? [];
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                shape: const DiamondCutCardShape(),
                title: Text(task.title),
                trailing: task.isDone ? const Icon(Icons.check) : null,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DiamondCutCardShape extends ShapeBorder {
  final double borderRadius;

  const DiamondCutCardShape({this.borderRadius = 16.0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final double halfWidth = rect.width / 2.5;
    final double oneThirdHeight = rect.height / 3;

    path.moveTo(rect.left + borderRadius, rect.top);
    path.lineTo(rect.left + halfWidth - borderRadius, rect.top);
    path.quadraticBezierTo(
      rect.left + halfWidth,
      rect.top,
      rect.left + halfWidth,
      rect.top + borderRadius * 2.4,
    );
    path.lineTo(
      rect.left + halfWidth,
      rect.top + oneThirdHeight - borderRadius,
    );
    path.quadraticBezierTo(
      rect.left + halfWidth,
      rect.top + oneThirdHeight,
      rect.left + halfWidth + borderRadius,
      rect.top + oneThirdHeight,
    );

    path.lineTo(rect.right - borderRadius, rect.top + oneThirdHeight);
    path.quadraticBezierTo(
      rect.right,
      rect.top + oneThirdHeight,
      rect.right,
      rect.top + oneThirdHeight + borderRadius,
    );

    path.lineTo(rect.right, rect.bottom - borderRadius);
    path.quadraticBezierTo(
      rect.right,
      rect.bottom,
      rect.right - borderRadius,
      rect.bottom,
    );

    path.lineTo(rect.left + borderRadius, rect.bottom);
    path.quadraticBezierTo(
      rect.left,
      rect.bottom,
      rect.left,
      rect.bottom - borderRadius,
    );

    path.lineTo(rect.left, rect.top + borderRadius);
    path.quadraticBezierTo(
      rect.left,
      rect.top,
      rect.left + borderRadius,
      rect.top,
    );

    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
