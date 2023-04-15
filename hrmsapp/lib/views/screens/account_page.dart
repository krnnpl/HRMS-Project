import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/employee_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var employeeController = Get.put(EmployeeController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Employee Name"),
        ),
        body: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 100,
                  child: Text(
                    "S",
                    textScaleFactor: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      employeeController.employee['message']?['name'] ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(employeeController.employee['message']
                          ?['username'] ??
                      ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      employeeController.employee['message']?['email'] ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      employeeController.employee['message']?['number'] ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(employeeController.employee['message']
                          ?['designation']?['name'] ??
                      ''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
