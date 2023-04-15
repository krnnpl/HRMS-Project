// To parse this JSON data, do
//
//     final payrollModel = payrollModelFromJson(jsonString);

import 'dart:convert';

PayrollModel payrollModelFromJson(String str) =>
    PayrollModel.fromJson(json.decode(str));

String payrollModelToJson(PayrollModel data) => json.encode(data.toJson());

class PayrollModel {
  PayrollModel({
    required this.message,
  });

  List<Message> message;

  factory PayrollModel.fromJson(Map<String, dynamic> json) => PayrollModel(
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.id,
    required this.year,
    required this.month,
    required this.salary,
    required this.overtime,
    required this.payrollDeduction,
    required this.grossSalary,
    required this.tax,
    required this.taxAmt,
    required this.netSalary,
    required this.name,
  });

  int id;
  String year;
  String month;
  int salary;
  int overtime;
  int payrollDeduction;
  int grossSalary;
  double tax;
  int taxAmt;
  int netSalary;
  Name name;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        year: json["year"],
        month: json["month"],
        salary: json["salary"],
        overtime: json["overtime"],
        payrollDeduction: json["payroll_deduction"],
        grossSalary: json["gross_salary"],
        tax: json["tax"]?.toDouble(),
        taxAmt: json["tax_amt"],
        netSalary: json["net_salary"],
        name: Name.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "month": month,
        "salary": salary,
        "overtime": overtime,
        "payroll_deduction": payrollDeduction,
        "gross_salary": grossSalary,
        "tax": tax,
        "tax_amt": taxAmt,
        "net_salary": netSalary,
        "name": name.toJson(),
      };
}

class Name {
  Name({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.number,
    required this.address,
    required this.panno,
    required this.password,
    required this.isAdmin,
    required this.designation,
  });

  int id;
  String name;
  String username;
  String email;
  String number;
  String address;
  String panno;
  String password;
  bool isAdmin;
  int designation;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        number: json["number"],
        address: json["address"],
        panno: json["panno"],
        password: json["password"],
        isAdmin: json["is_admin"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "number": number,
        "address": address,
        "panno": panno,
        "password": password,
        "is_admin": isAdmin,
        "designation": designation,
      };
}
