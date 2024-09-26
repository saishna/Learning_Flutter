import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskManagerScreen(),
    );
  }
}

class TaskManagerScreen extends StatefulWidget {
  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  List<Map<String, dynamic>> _tasks = [];
  final _taskController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks on startup
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getString('tasks');
    if (savedTasks != null) {
      setState(() {
        _tasks = List<Map<String, dynamic>>.from(json.decode(savedTasks));
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', json.encode(_tasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Enter Task'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Enter Due Date'),
            ),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            Expanded(
              child: _tasks.isEmpty
                  ? Center(child: Text('No tasks yet!'))
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index]['task']),
                    subtitle: Text('Due: ${_tasks[index]['dueDate']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTask() {
    if (_taskController.text.isEmpty || _dateController.text.isEmpty) return;

    setState(() {
      _tasks.add({
        'task': _taskController.text,
        'dueDate': _dateController.text,
      });
      _taskController.clear();
      _dateController.clear();
    });
    _saveTasks(); // Save tasks after adding
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks(); // Save tasks after deleting
  }
}
