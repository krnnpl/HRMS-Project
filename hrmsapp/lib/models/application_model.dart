// To parse this JSON data, do
//
//     final applicationModel = applicationModelFromJson(jsonString);

import 'dart:convert';

ApplicationModel applicationModelFromJson(String str) =>
    ApplicationModel.fromJson(json.decode(str));

String applicationModelToJson(ApplicationModel data) =>
    json.encode(data.toJson());

class ApplicationModel {
  ApplicationModel({
    required this.message,
  });

  Message message;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.id,
    required this.type,
    required this.title,
    required this.reason,
    required this.startDate,
    required this.days,
    required this.status,
    required this.employeeId,
  });

  int id;
  String type;
  String title;
  String reason;
  DateTime startDate;
  int days;
  String status;
  int employeeId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        reason: json["reason"],
        startDate: DateTime.parse(json["start_date"]),
        days: json["days"],
        status: json["status"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "reason": reason,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "days": days,
        "status": status,
        "employee_id": employeeId,
      };
}
