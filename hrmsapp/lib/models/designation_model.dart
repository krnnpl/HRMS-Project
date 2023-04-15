// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

DesignationModel designationModelFromJson(String str) =>
    DesignationModel.fromJson(json.decode(str));

String designationModelToJson(DesignationModel data) =>
    json.encode(data.toJson());

class DesignationModel {
  DesignationModel({
    required this.message,
  });

  List<Message> message;

  factory DesignationModel.fromJson(Map<String, dynamic> json) =>
      DesignationModel(
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
    required this.name,
    required this.salary,
  });

  int id;
  String name;
  int salary;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        name: json["name"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "salary": salary,
      };
}
