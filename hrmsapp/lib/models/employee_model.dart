// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) =>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  EmployeeModel({
    required this.message,
  });

  Message message;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.number,
    required this.address,
    required this.panno,
    required this.password,
    required this.isAdmin,
    required this.designationId,
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
  int designationId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        number: json["number"],
        address: json["address"],
        panno: json["panno"],
        password: json["password"],
        isAdmin: json["is_admin"],
        designationId: json["designation_id"],
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
        "designation_id": designationId,
      };
}
