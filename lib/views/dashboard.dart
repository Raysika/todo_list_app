import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/controllers/logincontroller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // List to hold tasks
  List<Map<String, dynamic>> tasks = [];
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    LoginController loginController = Get.put(LoginController());
    String userid = loginController.email.value;

    try {
      final response = await http.get(
        Uri.parse(
            'https://acs314flutter.xyz/ray_students/fetch_tasks.php?user_id=$userid'),
      );

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        if (serverResponse['success'] == 1) {
          List<Map<String, dynamic>> tasksList =
              List<Map<String, dynamic>>.from(serverResponse['tasks']);

          tasksList = tasksList
              .map((task) => {
                    ...task,
                    'completed': task['completed'] ?? '0',
                  })
              .toList();

          setState(() {
            tasks = tasksList;
          });
        } else {
          print('Error fetching tasks: ${serverResponse['message']}');
        }
      } else {
        print('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

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
                setState(() {
                  tasks.add({
                    "title": taskNameController.text,
                    "description": taskDescriptionController.text,
                    "due_date": selectedDate?.toString() ?? "",
                    "completed": false
                  });
                });
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
                "Hello ${Get.find<LoginController>().firstName.value}, your tasks for today are:",
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
                        value: tasks[index]['completed']
                                    .toString()
                                    .compareTo("1") ==
                                0
                            ? true
                            : false,
                        onChanged: (bool? value) {
                          setState(() {
                            String val = value! ? "1" : "0";
                            String taskid = tasks[index]['id'];

                            //debugging
                            //print(taskid);
                            updateStatus(taskid, val);

                            String snackbarMessage = value
                                ? 'Task completed'
                                : 'Task marked as incomplete';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(snackbarMessage),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          });
                        },
                      ),
                      title: Text(
                        tasks[index]['title'],
                        style: TextStyle(
                          decoration: tasks[index]['completed']
                                      .toString()
                                      .compareTo("1") ==
                                  0
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
                          if (tasks[index]['due_date'] != null &&
                              tasks[index]['due_date']!.isNotEmpty &&
                              tasks[index]['due_date'] != '0000-00-00')
                            Text("Due: ${tasks[index]['due_date']}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            String taskId = tasks[index]['id'];
                            deleteTask(taskId);
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

  void updateStatus(taskid, val) async {
    // ignore: unused_local_variable
    http.Response response;
    response = await http.get(Uri.parse(
        'https://acs314flutter.xyz/ray_students/updatestatus.php?taskid=$taskid&val=$val'));

    //debugging
    // print(response.body);
    // print(response.statusCode);
    fetchTasks();
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
      var serverResponse = json.decode(response.body);
      int postStatus = serverResponse['success'];
      if (postStatus == 1) {
        print('task posted');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task created successfully!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('task not posted');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create task.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://acs314flutter.xyz/ray_students/deletetasks.php?taskid=$taskId'));

    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      if (serverResponse['success'] == 1) {
        print('Task deleted');
        fetchTasks();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task deleted successfully.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('Failed to delete task: ${serverResponse['message']}');
      }
    } else {
      print('Failed to delete task: ${response.statusCode}');
    }
  }
}
