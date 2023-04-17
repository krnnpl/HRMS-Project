import 'package:get/get.dart';
import 'package:hrmsapp/controller/application_controller.dart';
import 'package:hrmsapp/controller/applicationlist_controller.dart';
import 'package:hrmsapp/controller/attendance_controller.dart';
import 'package:hrmsapp/controller/company_controller.dart';
import 'package:hrmsapp/controller/employee_controller.dart';
import 'package:hrmsapp/controller/payroll_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApplicationController());
    Get.put(ApplicationListController());
    Get.put(AttendanceController());
    Get.put(CompanyController());
    Get.put(EmployeeController());
    Get.put(PayrollController());
  }
}
