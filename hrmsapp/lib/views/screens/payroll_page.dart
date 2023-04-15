import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/payroll_controller.dart';

class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    var payrollController = Get.put(PayrollController());

    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Employee : ${payrollController.payroll['message']?[0]['name']?['name'] ?? ''}",
            ),
            Text(
              "Year : ${payrollController.payroll['message']?[0]['year'] ?? ''}",
            ),
            Text(
              "month : ${payrollController.payroll['message']?[0]['month'] ?? ''}",
            ),
            Text(
              "salary : ${payrollController.payroll['message']?[0]['salary'] ?? ''}",
            ),
            Text(
              "overtime : ${payrollController.payroll['message']?[0]['overtime'] ?? ''}",
            ),
            Text(
              "payrol_deduction : ${payrollController.payroll['message']?[0]['payrol_deduction'] ?? ''}",
            ),
            Text(
              "gross_salary : ${payrollController.payroll['message']?[0]['gross_salary'] ?? ''}",
            ),
            Text(
              "tax : ${payrollController.payroll['message']?[0]['tax'] ?? ''}",
            ),
            Text(
              "tax_amount : ${payrollController.payroll['message']?[0]['tax_amount'] ?? ''}",
            ),
            Text(
              "tax_amt : ${payrollController.payroll['message']?[0]['tax_amt'] ?? ''}",
            ),
            Text(
              "net_salary : ${payrollController.payroll['message']?[0]['net_salary'] ?? ''}",
            ),
          ],
        ));
  }
}
