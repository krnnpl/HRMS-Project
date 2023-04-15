import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrmsapp/views/screens/change_password.dart';
import 'package:hrmsapp/views/screens/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
    );
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.purple,
      // add any other properties for the dark theme here
    );

    return ListView(
      children: [
        ExpansionTile(
          title: const Text("Theme"),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dark Theme"),
                  Switch(
                    value: Get.isDarkMode,
                    onChanged: (value) {
                      if (value == true) {
                        Get.changeTheme(darkTheme);
                        value = true;
                        setState(() {});
                      } else {
                        Get.changeTheme(lightTheme);
                        value = false;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () => Get.to(const ChangePasswordView()),
          child: const ListTile(
            title: Text("Change Password"),
            trailing: Icon(Icons.change_circle_outlined),
          ),
        ),
        const CustomDivider(),
        GestureDetector(
          onTap: () => Get.offAll(const LoginPage()),
          child: const ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.exit_to_app_outlined),
          ),
        ),
        const CustomDivider(),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20,
      color: Colors.purple[300],
    );
  }
}
