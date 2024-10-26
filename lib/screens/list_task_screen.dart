// screens/list_task_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import '../providers/task_provider.dart';

class ListTaskScreen extends StatelessWidget {
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Normal':
        return Colors.blue;
      case 'Low':
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              Provider.of<TaskProvider>(context, listen: false).updateSortBy(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Name', child: Text('Sort by Name')),
              PopupMenuItem(value: 'Date Created', child: Text('Sort by Date Created')),
              PopupMenuItem(value: 'Due Date', child: Text('Sort by Due Date')),
              PopupMenuItem(value: 'Priority', child: Text('Sort by Priority')),
            ],
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.description,
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Created: ${DateFormat('yyyy-MM-dd').format(task.createdAt)}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      if (task.dueDate != null) ...[
                        Text(
                          'Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ] else ...[
                        Text(
                          'Due: Not Set',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ],
                  ),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? newValue) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .toggleTaskCompletion(task.id);
                    },
                  ),
                  onTap: () {
                    Provider.of<TaskProvider>(context, listen: false)
                        .toggleTaskCompletion(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
