1. Imports

import 'package:flutter/material.dart';

This imports Flutter's material package, which provides pre-built UI components and themes following the Material Design guidelines. It includes widgets like Scaffold, AppBar, TextField, etc.
2. Main Function

void main() {
  runApp(TaskManagerApp());
}

void main(): The entry point of every Flutter app.
runApp(TaskManagerApp()): This function tells Flutter to render the TaskManagerApp widget as the root of the app.

3. TaskManagerApp Class

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

TaskManagerApp: This is the root widget of your app.
StatelessWidget: Since TaskManagerApp doesn’t need to manage any state, it extends StatelessWidget.
build method: Every Flutter widget has a build method, which describes the widget's UI.
MaterialApp: A wrapper that configures the app, including navigation, theming, and title.
title: Sets the title of the app, which can be shown in the task switcher.
theme: Sets the visual style of the app (e.g., colors). Here, primarySwatch: Colors.blue gives a blue theme to the app.
home: Specifies the first screen of the app, which in this case is TaskManagerScreen().

4. TaskManagerScreen Class

class TaskManagerScreen extends StatefulWidget {
  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

TaskManagerScreen: This is the main screen where the task management functionality takes place.
StatefulWidget: It extends StatefulWidget because the UI will change over time (i.e., when tasks are added or deleted).
createState: This method creates the mutable state for TaskManagerScreen. It returns an instance of _TaskManagerScreenState, where the actual state and logic are maintained.

5. _TaskManagerScreenState Class

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  List<Map<String, dynamic>> _tasks = [];
  final _taskController = TextEditingController();
  final _dateController = TextEditingController();

_TaskManagerScreenState: This private class holds the state of the TaskManagerScreen.
_tasks: A list that stores the tasks. Each task is represented as a Map with two fields: 'task' (for the task name) and 'dueDate' (for the due date).
_taskController & _dateController: TextEditingController instances that handle the input from text fields for the task name and due date, respectively.

6. build Method

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

6.1 Scaffold Widget
Scaffold: Provides a base structure for the screen, including AppBar, Body, FloatingActionButton, etc.
AppBar: The top bar, containing the title 'Task Manager'.
6.2 Body Layout
Padding: Adds padding around the screen’s contents. In this case, padding is applied to all sides with a value of 8.0.
Column: A vertical layout. Each child widget inside the children list is arranged vertically.
6.3 Task Input Fields
TextField (Task Name): A widget that allows users to input text (in this case, the task name).
controller: _taskController: Links the TextField to the _taskController, which allows the app to retrieve the user's input.
InputDecoration: Adds styling and hints to the TextField, such as a label.
TextField (Due Date): Another text field for inputting the due date. It works similarly to the task name field, but uses _dateController.
6.4 Add Task Button
ElevatedButton: A button styled with elevation (shadows).
onPressed: _addTask: When pressed, it calls the _addTask() function to add the task to the list.
6.5 Task List
Expanded: Ensures the list takes up all the available space in the column.
_tasks.isEmpty ? Center(child: Text('No tasks yet!')): If the task list is empty, a Center widget shows a message 'No tasks yet!'.
ListView.builder: Dynamically generates a scrollable list of tasks from the _tasks list.
itemCount: _tasks.length: Specifies how many items the list will contain (based on the number of tasks).
itemBuilder: For each task, this function builds a ListTile:
title: Displays the task name.
subtitle: Displays the due date.
trailing: Adds a delete button (an icon) for each task.
onPressed: () => _deleteTask(index): When the delete button is pressed, it calls _deleteTask() for the specific task.

7. _addTask() Method

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
}

Purpose: Adds a new task to the list.
Condition: If the user hasn't entered a task or a due date, the method returns without adding anything.
setState(): This is a special Flutter function that notifies the framework that the state has changed, prompting the UI to rebuild with the new data.
_tasks.add(): Adds a new task to the _tasks list, containing the task name and due date.
_taskController.clear() & _dateController.clear(): Clears the input fields after adding a task.

8. _deleteTask() Method

void _deleteTask(int index) {
  setState(() {
    _tasks.removeAt(index);
  });
}

Purpose: Deletes the task at the given index.
setState(): As with adding, this triggers the UI to rebuild, showing the updated list without the deleted task.

Conclusion:
App Flow: The app allows users to add tasks with a due date, displays them in a list, and offers the ability to delete tasks.
State Management: The use of setState() ensures that any changes to the task list are immediately reflected in the UI.



New Imports
dart
Copy code
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

dart:convert: This package is imported to handle JSON encoding and decoding, which is needed to store the tasks in a format that SharedPreferences supports (a string).
shared_preferences: This package allows the app to persist data locally on the user's device, so that tasks can be saved and loaded later.

1. Loading and Saving Tasks
The main functionality added here is the ability to load tasks from persistent storage when the app starts and save tasks whenever a task is added or deleted.
1.1 initState()

@override
void initState() {
  super.initState();
  _loadTasks(); // Load tasks on startup
}

initState(): This method is part of the StatefulWidget lifecycle and is called when the widget is first created.
_loadTasks(): This function is called when the app starts to load any previously saved tasks.
1.2 _loadTasks() Method

Future<void> _loadTasks() async {
  final prefs = await SharedPreferences.getInstance();
  final savedTasks = prefs.getString('tasks');
  if (savedTasks != null) {
    setState(() {
      _tasks = List<Map<String, dynamic>>.from(json.decode(savedTasks));
    });
  }
}

SharedPreferences.getInstance(): This gets an instance of SharedPreferences, which is used to read and write data on the device.
prefs.getString('tasks'): Retrieves the stored string under the key 'tasks'. If no tasks are saved, it returns null.
json.decode(savedTasks): Converts the JSON string back into a Dart object (list of tasks).
List<Map<String, dynamic>>.from(): Ensures that the decoded data is in the format of a list of maps (List<Map<String, dynamic>>).
setState(): Updates the state of the app so the loaded tasks are reflected in the UI.
1.3 _saveTasks() Method

Future<void> _saveTasks() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('tasks', json.encode(_tasks));
}

prefs.setString('tasks', json.encode(_tasks)): This converts the task list to a JSON string using json.encode() and saves it in SharedPreferences under the key 'tasks'. This ensures that the task list is preserved between app sessions.

2. Changes in _addTask() Method

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

_saveTasks(): After a new task is added, the app calls _saveTasks() to save the updated list of tasks to persistent storage, ensuring it’s retained after the app is closed.

3. Changes in _deleteTask() Method

void _deleteTask(int index) {
  setState(() {
    _tasks.removeAt(index);
  });
  _saveTasks(); // Save tasks after deleting
}

_saveTasks(): Similarly, when a task is deleted, _saveTasks() is called to save the updated list, ensuring the deletion is reflected in the persistent storage.

4. Unchanged Code
The rest of the code (UI layout, task display, input fields) remains the same as in the previous version. The app continues to use:
TextField: For task name and due date input.
ElevatedButton: To trigger task addition.
ListView.builder: To display the list of tasks.
ListTile: To format each task item with a delete button.

Conclusion
Persistent Storage: The major update here is the use of SharedPreferences to save and load tasks using JSON encoding/decoding. This ensures that tasks remain available even after the app is closed and reopened.
Functionality: Every time a task is added or deleted, the app saves the updated task list to persistent storage. When the app starts, the saved tasks are loaded back into the list.

