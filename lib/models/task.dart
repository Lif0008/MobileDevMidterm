// models/task.dart

class Task {
  final String id;
  final String title;
  final String description;  
  final bool isCompleted;
  final String priority;
  final DateTime createdAt;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description, 
    this.isCompleted = false,
    this.priority = 'Normal',
    required this.createdAt,
    this.dueDate,
  });
}
