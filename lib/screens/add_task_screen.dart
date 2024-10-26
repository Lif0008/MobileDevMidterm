// screens/add_task_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _priority = 'Normal';
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: _priority,
              items: ['Low', 'Normal', 'High'].map((String priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _priority = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                _dueDate == null
                    ? 'Select Due Date'
                    : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dueDate = pickedDate; // Set due date correctly
                  });
                }
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    priority: _priority,
                    dueDate: _dueDate,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Add Task', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
