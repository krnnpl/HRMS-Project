import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/views/screens/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/application_model.dart';

class ApplicationController extends GetxController {
  var client = http.Client();
  var applicationList = <ApplicationModel>[].obs;
  int? userId = 0;
  var isLoading = true.obs;

  Future<void> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

  Future<List<ApplicationModel>?> postApplication(Map application) async {
    try {
      isLoading(true);

      var response = await client.post(
        Uri.parse("http://127.0.0.1:8000/api/applications/"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: jsonEncode(application),
      );
      if (response.statusCode == 201) {
        Get.defaultDialog(
          title: "Success",
          content: const Text("Successfully sent application"),
          confirm: ElevatedButton(
            onPressed: () => Get.offAll(const BasePage()),
            child: const Text("OK"),
          ),
        );
      } else {
        Get.defaultDialog(
            title: "Error",
            content: Text('Error posting data: ${response.statusCode}'));
      }
    } catch (e) {
      Get.defaultDialog(title: "Post error", content: Text(e.toString()));
    } finally {
      isLoading(false);
    }
    return null;
  }

  @override
  void onInit() {
    getUserId();
    super.onInit();
  }
}
