import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/controllers/logincontroller.dart';

import 'package:my_app/views/custombutton.dart';
import 'package:my_app/views/customtext.dart';
import 'package:my_app/views/customtextfield.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
LoginController loginController = Get.put(LoginController());
class Login extends StatelessWidget {
   const Login({super.key});
  @override
  Widget build(BuildContext context) {
    

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
          automaticallyImplyLeading: false,
        ),
        body: Container(
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
                    userFieldController: emailController,
                    icon: Icons.person,
                    hint: "Your E-mail",
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
                    labelButton: "Login", 
                    action: (){
                      loginUser(context);
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
  Future<void> loginUser(BuildContext context) async {
    http.Response response;
    
    response = await http.get(Uri.parse(
        'https://acs314flutter.xyz/ray_students/login.php?email=${emailController.text.trim()}&password=${passwordController.text.trim()}'));

    
      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        int loginStatus = serverResponse['success'];
        if (loginStatus == 1){
          var userData = serverResponse['userdata'];

          //debugging
          //print (userData);
          //print(userData[0]['last_name']);
          var email = userData[0]['email'];
          var firstName = userData[0]['first_name'];
          var lastName = userData[0]['last_name'];
          loginController.updateEmail(email);
          loginController.updateFirstName(firstName);
          loginController.updateLastName(lastName);
          Get.toNamed('/dashboard');
        } else {
          
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Incorrect login details"),
            duration: Duration(seconds: 3),
          ),
        );
        }
      } else {
        print ("Server Error ${response.statusCode}");
      }
  }
  }


