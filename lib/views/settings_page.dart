import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/configs/constants.dart';
import 'package:my_app/controllers/logincontroller.dart';
import 'package:settings_ui/settings_ui.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Scaffold(
      backgroundColor:
          orangeColor, 

      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('General'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(Icons.person),
                title: Text('Account'),
                onPressed: (BuildContext context) {
                  // Navigate to account settings or open a dialog
                   showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Account Details'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Full Name: ${loginController.firstName.value} ${loginController.lastName.value}'),
                            Text('Email: ${loginController.email.value}'),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Security'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                onPressed: (BuildContext context) {
                  // Navigate to change password screen
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('About'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(Icons.info),
                title: Text('About'),
                onPressed: (BuildContext context) {
                  showAboutDialog(
                    context: context,
                    applicationName: 'TaskTrove',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2024 TaskTrove',
                    children: <Widget>[
                      Text('TaskTrove is designed to streamline your task management, helping you stay organized and focused.'),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate back to the login screen
          Get.offAndToNamed('/login');
        },
        child: Icon(Icons.logout),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
