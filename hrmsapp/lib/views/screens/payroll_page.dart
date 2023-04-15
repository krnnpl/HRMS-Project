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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "Employee : ${payrollController.payroll['message']?[0]['name']?['name'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "Month : ${payrollController.payroll['message']?[0]['year'] ?? ''} - ${payrollController.payroll['message']?[0]['month'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "salary : ${payrollController.payroll['message']?[0]['salary'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "overtime : ${payrollController.payroll['message']?[0]['overtime'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "Deduction : ${payrollController.payroll['message']?[0]['payroll_deduction'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "Gross : ${payrollController.payroll['message']?[0]['gross_salary'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                    "Tax Reduction : ${payrollController.payroll['message']?[0]['tax_amt'] ?? ''}",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Net Salary : ${payrollController.payroll['message']?[0]['net_salary'] ?? ''}",
                  textScaleFactor: 1.6,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
