// providers/task_provider.dart

import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isDarkMode = false;
  String _sortBy = 'Name';

  List<Task> get tasks {
    _sortTasks();
    return _tasks;
  }

  bool get isDarkMode => _isDarkMode;
  String get sortBy => _sortBy;

  // Update the sorting criteria
  void updateSortBy(String criteria) {
    _sortBy = criteria;
    notifyListeners();
  }

  // Add a new task with description and priority
  void addTask({
    required String title,
    required String description,
    String priority = 'Normal',
    DateTime? dueDate,
  }) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      priority: priority,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );
    _tasks.add(newTask);
    _sortTasks();
    notifyListeners();
  }

  // Toggle task completion status
  void toggleTaskCompletion(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: _tasks[taskIndex].id,
        title: _tasks[taskIndex].title,
        description: _tasks[taskIndex].description,
        isCompleted: !_tasks[taskIndex].isCompleted,
        priority: _tasks[taskIndex].priority,
        createdAt: _tasks[taskIndex].createdAt,
        dueDate: _tasks[taskIndex].dueDate,
      );
      notifyListeners();
    }
  }

  // Remove a task by ID
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Toggle dark mode
  void toggleDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  // Sort tasks based on the current criteria
  void _sortTasks() {
    switch (_sortBy) {
      case 'Date Created':
        _tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'Due Date':
        _tasks.sort((a, b) => (a.dueDate ?? DateTime.now()).compareTo(b.dueDate ?? DateTime.now()));
        break;
      case 'Priority':
        _tasks.sort((a, b) => a.priority.compareTo(b.priority));
        break;
      case 'Name':
      default:
        _tasks.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}
