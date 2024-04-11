import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/views/registration.dart';
import 'package:my_app/views/custombutton.dart';
import 'package:my_app/views/customtext.dart';
import 'package:my_app/views/customtextfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
        body: Container(
          //decoration: BoxDecoration(
          //image: DecorationImage(
          //image: AssetImage(
          //"assets/images/background.jpg"), // Add your background image)
          //fit: BoxFit.cover,
          //),
          //),

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/logo.png",
                          height: 100, width: 100)
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customtitleText(
                          label: "Login Screen",
                          labelColor: orangeColor,
                          fontSize: 30)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const customtitleText(label: "Username"),
                  customTextField(
                    userFieldController: userNameController,
                    icon: Icons.person,
                    hint: "Username or Email or Phone Number",
                  ),
                  const customtitleText(label: "Password"),
                  customTextField(
                      userFieldController: passwordController,
                      icon: Icons.lock,
                      hideText: true,
                      isPassword: true,
                      hint: "Your Girlfriend's Birthday"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    labelButton: "Login", // Set the label for the Login button
                    action: (){
                      Get.offAndToNamed("/dashboard");
                    }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const customtitleText(label: "Forgot Password?"),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: const customtitleText(
                          label: "Recover",
                          labelColor: orangeColor,
                        ),
                        onTap: () {
                          print("Recovered Password");
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const customtitleText(label: "No account yet?"),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: const customtitleText(
                          label: "Register",
                          labelColor: orangeColor,
                        ),
                        onTap: () {
                          Get.toNamed("/registration");
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
