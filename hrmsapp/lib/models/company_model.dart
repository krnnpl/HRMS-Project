// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    required this.message,
  });

  Message message;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.id,
    required this.companyName,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.estd,
  });

  int id;
  String companyName;
  String address;
  String phoneNumber;
  String email;
  String estd;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        companyName: json["company_name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        estd: json["estd"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "address": address,
        "phone_number": phoneNumber,
        "email": email,
        "estd": estd,
      };
}
