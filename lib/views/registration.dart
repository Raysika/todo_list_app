import 'package:flutter/material.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/views/custombutton.dart';
import 'package:my_app/views/customtextfield.dart';
import 'package:my_app/views/customtext.dart';

import 'package:my_app/views/login.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController phonenumberController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TaskTrove",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: orangeColor,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", height: 100, width: 100)
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customtitleText(
                    label: "Registration Screen",
                    labelColor: orangeColor,
                    fontSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const customtitleText(label: "First Name"),
              customTextField(
                userFieldController: firstnameController,
                icon: Icons.person_add,
                hint: "Enter your First Name",
              ),
              const customtitleText(label: "Last Name"),
              customTextField(
                userFieldController: lastnameController,
                icon: Icons.person_add_alt_1,
                hint: "Enter your Last Name",
              ),
              const customtitleText(label: "Username"),
              customTextField(
                userFieldController: usernameController,
                icon: Icons.person_3_rounded,
                hint: "Enter your username",
              ),
              const customtitleText(label: "Phone Number"),
              customTextField(
                userFieldController: phonenumberController,
                icon: Icons.phone,
                hint: "Enter your Phone Number",
              ),
              const customtitleText(label: "Email"),
              customTextField(
                userFieldController: emailController,
                icon: Icons.email,
                hint: "Enter your email",
              ),
              const customtitleText(label: "Password"),
              customTextField(
                userFieldController: passwordController,
                icon: Icons.lock,
                hideText: true,
                isPassword: true,
                hint: "Enter your password",
              ),
              const customtitleText(label: "Repeat Password"),
              customTextField(
                userFieldController: repasswordController,
                icon: Icons.password,
                hideText: true,
                isPassword: true,
                hint: "Re-enter your password",
              ),
              const SizedBox(height: 20),
              CustomButton(
                labelButton:
                    "Register", // Set the label for the Register button
                isRegistration: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const customtitleText(label: "Already have an account?"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: const customtitleText(
                      label: "Login",
                      labelColor: orangeColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
