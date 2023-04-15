import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/attendance_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var attendanceController = Get.put(AttendanceController());
    var length = attendanceController.attendance['message']?.length ?? 0;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Attendances $length",
              textScaleFactor: 3,
            ),
          ),
          SizedBox(
            width: Get.size.width * 0.8,
            child: DataTable(
              sortAscending: true,
              columns: const [
                DataColumn(
                  label: Text('Date'),
                ),
                DataColumn(
                  label: Text('Time'),
                ),
              ],
              rows: List.generate(
                length,
                (index) {
                  // For each item in the attendanceData list, create a DataRow widget
                  return DataRow(
                    cells: [
                      DataCell(Text(attendanceController.attendance['message']
                              ?[index]?["date"] ??
                          '')),
                      DataCell(Text(attendanceController.attendance['message']
                              ?[index]?["time"] ??
                          '')),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
