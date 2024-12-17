import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database_service.dart';
import '../models/task.dart';
import '../theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  String? _task = null;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      floatingActionButton: _addTaskButton(),
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          //delete task button
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),

          // delete all tasks button
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _showDeleteAllConfirmationDialog();
            },
          ),
        ],
      ),
      body: _tasksList(),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
      future: _databaseService.getTasks(),
      builder: (context, snapshot) {
        // If the snapshot has no data or is empty, show the "no tasks" message
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No tasks, press the button to add task',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              Task task = snapshot.data![index];
              return ListTile(
                onTap: () {},
                title: Text(
                  task.content,
                  style: TextStyle(
                    fontSize: 22,
                    decoration:
                        task.status == 1 ? TextDecoration.lineThrough : null,
                    decorationThickness: 2.0,
                    decorationColor: Colors.red,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: task.status == 1,
                      onChanged: (value) {
                        _databaseService.updateTaskStatus(
                          task.id,
                          value == true ? 1 : 0,
                        );
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showConfirmationDialog(task);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

// add task button
  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Add Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _task = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add task...',
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (_task == null || _task == "") return;
                    _databaseService.addTask(_task!);
                    setState(() {
                      _task = null;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
      future: _databaseService.getTasks(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Task task = snapshot.data![index];
            return ListTile(
              onTap: () {},
              title: Text(
                task.content,
                style: TextStyle(
                  fontSize: 22,
                  decoration:
                      task.status == 1 ? TextDecoration.lineThrough : null,
                  decorationThickness: 2.0,
                  decorationColor: Colors.red,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: task.status == 1,
                    onChanged: (value) {
                      _databaseService.updateTaskStatus(
                        task.id,
                        value == true ? 1 : 0,
                      );
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showConfirmationDialog(task);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showConfirmationDialog(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _databaseService.deleteTask(task.id);
                setState(() {});
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
