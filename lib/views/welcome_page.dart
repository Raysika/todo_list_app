// welcome_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/views/login.dart';
import 'package:my_app/views/registration.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "TaskTrove",
                  style: TextStyle(
                    color: orangeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              "assets/images/logo.png", // Replace with the actual path
              height: 200.0,
              width: 200.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Organize your work and life finally.",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Get.toNamed("/registration");
              },
              child: const Text(
                "Register",
                style: TextStyle(
                  color: orangeColor, // Customize the color as needed
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: () {
                Get.toNamed("/login");
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: orangeColor, // Customize the color as needed
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
