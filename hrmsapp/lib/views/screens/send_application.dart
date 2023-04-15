import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/application_controller.dart';
import 'package:hrmsapp/views/widgets/widget_gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendApplication extends StatefulWidget {
  const SendApplication({super.key});

  @override
  State<SendApplication> createState() => _SendApplicationState();
}

class _SendApplicationState extends State<SendApplication> {
  var applicationController = Get.put(ApplicationController());

  final _formKey = GlobalKey<FormState>();
  String typeValue = 'Leave Request';
  String dayValue = '1';
  String? _selectedDate;
  String title = '';
  String reason = '';
  int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply for an issue"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Get info",
                  content: const Text("data"),
                );
              },
              icon: const Icon(
                Icons.info,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const WidgetGap(),
            const Text("Please fill up following details"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Type"),
                DropdownButton<String>(
                  value: typeValue,
                  items: <String>['Leave Request', 'Suggestions', 'Allowance']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      typeValue = newValue!;
                    });
                  },
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Please enter the title';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            const WidgetGap(),
            TextFormField(
              maxLines: 9,
              decoration: const InputDecoration(labelText: 'Reason'),
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Please enter your reason';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  reason = value;
                });
              },
            ),
            const WidgetGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Select Date"),
                ElevatedButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    _selectedDate != null
                        ? _selectedDate.toString()
                        : 'No date selected!',
                  ),
                ),
              ],
            ),
            const WidgetGap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Days"),
                DropdownButton<String>(
                  // Step 3.
                  value: dayValue,
                  // Step 4.
                  items: <String>[
                    // 'Choose One',
                    '1',
                    '2',
                    '3'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      dayValue = newValue!;
                    });
                  },
                ),
              ],
            ),
            const WidgetGap(),
            SizedBox(
              width: Get.size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  userId = await getUserId();
                  print("$typeValue,$title,$reason,$_selectedDate,$dayValue");
                  Map application = {
                    "type": typeValue,
                    "title": title,
                    "reason": reason,
                    "start_date": _selectedDate,
                    "days": dayValue,
                    "status": "Pending",
                    "employee_id": userId
                  };
                  print(application);
                  applicationController.postApplication(application);
                },
                child: const Text(
                  "Send Application",
                  textScaleFactor: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    return userId;
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        String date =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        _selectedDate = date;
      });
    });
  }
}
