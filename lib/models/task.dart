// lib/models/task.dart
class Task {
  final String name;
  final String description;
  final bool highPriority;
  bool isDone;

  Task({
    required this.name,
    required this.description,
    this.highPriority = false,
    this.isDone = false,
  });
}
