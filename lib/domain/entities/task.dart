class Task {
  final String id;
  final String description;
  final String title;
  final bool isDone;
  final String userId;

  Task({
    required this.description,
    required this.id,
    required this.title,
    required this.isDone,
    required this.userId,
  });
}
