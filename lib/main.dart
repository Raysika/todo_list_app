// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/utils/routes.dart';
import 'views/welcome_page.dart'; // Assuming you have a WelcomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TaskTrove',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[600], // Light shade of orange

        scaffoldBackgroundColor:
            Colors.orange[100], // Light shade of orange background for pages
        appBarTheme: AppBarTheme(
          color: Colors.orange[900], // Dark shade of orange for app bar
        ),
        textTheme: TextTheme(
          bodyLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          bodyMedium:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          titleLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          // Add more text styles as needed
        ),
      ),
      initialRoute: "/",
      getPages: Routes.routes,
      
      debugShowCheckedModeBanner: false,
    );
  }
}
