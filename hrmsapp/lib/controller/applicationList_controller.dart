import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationListController extends GetxController {
  var client = http.Client();
  var applicationlist = {}.obs;
  int? userId = 0;

  Future<void> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

  Future fetchApplicationList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      // print('The user ID is $userId');
      // print(userId);
      var response =
          // await client.get(Uri.parse("http://127.0.0.1:8000/api/employee/2/"));
          await client.get(Uri.parse(
              "http://127.0.0.1:8000/api/employeeapplication/$userId"));
      // "http://127.0.0.1:8000/api/employeeapplication/$userId/"));

      if (response.statusCode == 200) {
        applicationlist.value = jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Remote service error",
        content: Text(e.toString()),
      );
    }
    return null;
  }

  @override
  void onInit() {
    fetchApplicationList();
    getUserId();
    // fetchDesignations();
    super.onInit();
  }
}
