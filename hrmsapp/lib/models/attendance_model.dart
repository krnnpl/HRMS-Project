// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    required this.message,
  });

  List<Message> message;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
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
    required this.date,
    required this.time,
    required this.name,
  });

  int id;
  DateTime date;
  String time;
  Name name;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        name: Name.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
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
