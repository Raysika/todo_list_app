import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/controllers/logincontroller.dart';
import 'package:my_app/views/login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // List to hold tasks
  List<Map<String, dynamic>> tasks = [];

  Future<void> _showTaskInputDialog(BuildContext context) async {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController taskDescriptionController =
        TextEditingController();
    DateTime? selectedDate;
    LoginController loginController = Get.put(LoginController());

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
                setState(() {
                  tasks.add({
                    "title": taskNameController.text,
                    "description": taskDescriptionController.text,
                    "due_date": selectedDate?.toString() ?? "",
                    "completed": false
                  });
                });
                // Call postTask here with the necessary parameters
                postTask(
                    taskNameController.text,
                    taskDescriptionController.text,
                    selectedDate?.toString() ?? "");
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (tasks[index]['description'] != null &&
                              tasks[index]['description']!.isNotEmpty)
                            Text(tasks[index]['description']!),
                          if (tasks[index]['date'] != null &&
                              tasks[index]['date']!.isNotEmpty)
                            Text("Due: ${tasks[index]['date']}"),
                        ],
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
  Future<void> postTask(
      String title, String description, String due_date) async {
        http.Response response;
        var body = {
        'title': title,
        'description': description,
        'due_date': due_date,
        'user_id': loginController.email.value,
      };
        response = await http.post(
      Uri.parse('https://acs314flutter.xyz/ray_students/create_tasks.php'),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      var serverResponse = json.decode(response.body);
      int postStatus = serverResponse['success'];
      if (postStatus == 1){
        print('task posted');
      } else {
        print('task not posted');
      }
    }
  }  
}
