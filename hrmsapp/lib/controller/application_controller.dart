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

  Future<void> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

  // Future<List<ApplicationModel>?> fetchApplicationList() async {
  //   try {
  //     // isLoading(true);
  //     var data = await ApplicationRemote.fetchApplication();

  //     if (data != null) {
  //       applicationList.value = data;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     Get.defaultDialog(
  //       title: "Controller error",
  //       content: Text(e.toString()),
  //     );
  //   } finally {
  //     // isLoading(false);
  //   }
  //   return null;
  // }

  Future<List<ApplicationModel>?> postApplication(Map application) async {
    try {
      var response = await client.post(
        Uri.parse("http://127.0.0.1:8000/api/applications/"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: jsonEncode(application),
      );
      print(application);
      print(response.body);
      if (response.statusCode == 201) {
        Get.defaultDialog(
          title: "Success",
          content: Text("Successfully sent application"),
          confirm: ElevatedButton(
            onPressed: () => Get.offAll(BasePage()),
            child: Text("OK"),
          ),
        );
      } else {
        print('Error posting data: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(title: "Post error", content: Text(e.toString()));
    }
    return null;
  }

  @override
  void onInit() {
    // fetchApplicationList();
    getUserId();
    // fetchDesignations();
    super.onInit();
  }
}

// class ApplicationRemote {
//   static var client = http.Client();

//   static Future<List<ApplicationModel>?> fetchApplication() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       var response = await client
//           .get(Uri.parse("http://127.0.0.1:8000/api/employeeapplication/2"));
//       // Uri.parse("http://127.0.0.1:8000/api/employeeapplication/$userId"));
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         // print("jsonString= $jsonString");
//         var list = json.decode(jsonString) as List<dynamic>;
//         return list.map((json) => ApplicationModel.fromJson(json)).toList();
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       Get.defaultDialog(
//         title: "Remote service error",
//         content: Text(e.toString()),
//       );
//     }
//     return null;
//   }
// }
