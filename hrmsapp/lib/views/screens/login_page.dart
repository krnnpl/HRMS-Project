import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/views/screens/base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mysql1/mysql1.dart';
import '../widgets/widget_gap.dart';

class LoginPage extends StatefulWidget {
  // static var authtoken = "";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                textScaleFactor: 1.4,
                style: TextStyle(fontSize: 26.0),
              ),
              const WidgetGap(),
              const WidgetGap(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    const WidgetGap(),
                    SizedBox(
                      width: Get.size.width * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            _login();
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _login() async {
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
          'SELECT id FROM Employees WHERE username = ? AND password = ?',
          [_username, _password]);
      await conn.close();

      if (result.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('userId', result.first[0]);
        var id = result.first[0];

        Get.off(const BasePage());
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid username or password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred while logging in: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
