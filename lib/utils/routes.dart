import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/views/dashboard.dart';
import 'package:my_app/views/login.dart';
import 'package:my_app/views/navigation_bar.dart';
import 'package:my_app/views/registration.dart';
import 'package:my_app/views/welcome_page.dart';

class Routes {
  static var routes = [
    GetPage(
        name: "/",
        page: () =>
            WelcomePage()), // First screen is represented by the / route meaning the root of the app.
    GetPage(name: "/login", page: () => Login()),
    GetPage(name: "/registration", page: () => RegistrationScreen()),
    GetPage(name: "/home", page: () => Dashboard()),
    GetPage(name: "/dashboard", page: () => Navigation_Bar()),
  ];
}
