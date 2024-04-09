// settings_page.dart
import 'package:flutter/material.dart';

import 'package:my_app/views/login.dart'; // Import your login screen

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: const Text("Logout"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Button color
          ),
        ),
      ),
    );
  }
}
