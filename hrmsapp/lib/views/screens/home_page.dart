import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/attendance_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var attendanceController = Get.put(AttendanceController());
    var length = attendanceController.attendance['message']?.length ?? 0;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Attendances",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple,
                ),
                textScaleFactor: 3,
              ),
            ),
            SizedBox(
              width: Get.size.width * 0.8,
              child: DataTable(
                border: TableBorder.all(
                  color: Colors.purple,
                  width: 1.3,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                sortAscending: true,
                showBottomBorder: true,
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
      ),
    );
  }
}
