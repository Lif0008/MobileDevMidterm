import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart'; // Import for AddTaskScreen
import 'screens/list_task_screen.dart'; // Import for ListTaskScreen
import 'screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return MaterialApp(
            title: 'Task Manager',
            theme: ThemeData(
              brightness: taskProvider.isDarkMode ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => HomeScreen(),
              '/add-task': (context) => AddTaskScreen(),  // Make sure this class exists
              '/list-tasks': (context) => ListTaskScreen(),  // Make sure this class exists
              '/settings': (context) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
