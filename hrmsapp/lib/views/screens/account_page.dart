import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/employee_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var employeeController = Get.put(EmployeeController());
    var name = employeeController.employee['message']?['name'] ?? '';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Obx(
          () {
            if (employeeController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 100,
                        child: Icon(
                          Icons.person_2_outlined,
                          size: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Name: ${employeeController.employee['message']?['name'] ?? ''}",
                        textScaleFactor: 1.2,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Username: ${employeeController.employee['message']?['username'] ?? ''}',
                        textScaleFactor: 1.2,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email: ${employeeController.employee['message']?['email'] ?? ''}',
                        textScaleFactor: 1.2,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Contact: ${employeeController.employee['message']?['number'] ?? ''}',
                        textScaleFactor: 1.2,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Designation: ${employeeController.employee['message']?['designation']?['name'] ?? ''}',
                        textScaleFactor: 1.2,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
