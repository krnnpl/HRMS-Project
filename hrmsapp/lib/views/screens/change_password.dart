// import 'package:employeeapp/services/remote_services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/views/screens/login_page.dart';
import 'package:hrmsapp/views/widgets/widget_gap.dart';
import 'package:lottie/lottie.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  String _newpassword = '';
  // ignore: unused_field
  String _newpassword1 = '';
  int? userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Change password"),
        ),
        body: Column(
          children: [
            Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_1idqu1ac.json",
              height: 300,
            ),
            const WidgetGap(),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'New Password'),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter new password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _newpassword = value;
                        });
                      },
                    ),
                    const WidgetGap(),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Retype new password'),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please reenter your new password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _newpassword1 = value;
                        });
                      },
                    ),
                    const WidgetGap(),
                    SizedBox(
                      width: Get.size.width * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true) {
                            userId = await getUserId();
                            await _changepassword();
                            Get.defaultDialog(
                                title: "Password changed Successfully",
                                content: const Text("Login again"),
                                confirm: ElevatedButton(
                                  child: const Text("Ok"),
                                  onPressed: () =>
                                      Get.offAll(const LoginPage()),
                                ));
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "submit",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

  Future<void> _changepassword() async {
    try {
      var conn = await MySqlConnection.connect(ConnectionSettings(
        // host: 'localhost',
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: 'Hello12345',
        db: 'ehrms',
      ));

      final result = await conn.query(
          'UPDATE Employees SET password = ? WHERE id = ?',
          [_newpassword, userId]);
      await conn.close();

      if (result.isNotEmpty) {
        Get.defaultDialog(
            title: "Success", content: const Text("Updated successfully"));
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('An error occurred while changeing password in: $e'),
      );
    }
  }
}
