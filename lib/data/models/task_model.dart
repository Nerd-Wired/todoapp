class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final String userId;

  TaskModel( {
    required this.description,
    required this.isDone,
    required this.id,
    required this.title,
    required this.userId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      userId: map['user_id'],
      description: map['description']?? '',
      id: map['todo_id'],
      title: map['title'],
      isDone: map['is_done'],
    );
  }
  Map<String, dynamic> toMap(String userId) => {
    'title': title,
    'is_done': isDone,
    'user_id': userId,
  };
}
