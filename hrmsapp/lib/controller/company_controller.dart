import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyController extends GetxController {
  var client = http.Client();
  var company = {}.obs;
  var isLoading = true.obs;

  Future fetchCompany() async {
    try {
      isLoading(true);
      var response =
          await client.get(Uri.parse("http://127.0.0.1:8000/api/company/"));
      if (response.statusCode == 200) {
        company.value = jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Remote service error",
        content: Text(e.toString()),
      );
    } finally {
      isLoading(false);
    }
    return null;
  }

  @override
  void onInit() {
    fetchCompany();
    super.onInit();
  }
}
