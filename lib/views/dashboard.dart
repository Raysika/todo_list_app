import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Sample data for tasks
  List<Map<String, dynamic>> tasks = [
    {"title": "Task 1", "completed": false},
    {"title": "Task 2", "completed": false},
    {"title": "Task 3", "completed": false},
  ];
  Future<void> _showTaskInputDialog(BuildContext context) async {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController taskDescriptionController =
        TextEditingController();
    DateTime? selectedDate;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: taskNameController,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
                TextField(
                  controller: taskDescriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != selectedDate)
                      setState(() {
                        selectedDate = picked;
                      });
                  },
                ),
                if (selectedDate != null) Text(selectedDate.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Add task logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Hello Raymond, your tasks for today are:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: orangeColor),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: orangeColor,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Checkbox(
                        value: tasks[index]['completed'],
                        onChanged: (bool? value) {
                          setState(() {
                            tasks[index]['completed'] = value!;
                          });
                        },
                      ),
                      title: Text(
                        tasks[index]['title'],
                        style: TextStyle(
                          decoration: tasks[index]['completed']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskInputDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
