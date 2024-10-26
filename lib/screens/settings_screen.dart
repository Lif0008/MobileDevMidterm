import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.grey),
            SwitchListTile(
              contentPadding: EdgeInsets.only(left: 0.0, right: 8.0),
              title: Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              value: Provider.of<TaskProvider>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .toggleDarkMode(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
