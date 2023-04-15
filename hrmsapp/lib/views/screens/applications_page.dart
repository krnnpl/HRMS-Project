import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/applicationList_controller.dart';
import 'package:hrmsapp/controller/application_controller.dart';
import 'package:hrmsapp/views/screens/send_application.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    var applicationController = Get.put(ApplicationListController());
    // var length = applicationController.applicationList.length;
    var length = applicationController.applicationlist['message']?.length ?? 0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: Get.size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Get.to(const SendApplication()),
              child: Text(
                "Send Application $length",
                textScaleFactor: 1.3,
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.size.width,
          child: DataTable(
            sortAscending: true,
            columns: const [
              DataColumn(
                label: Text('Title'),
              ),
              DataColumn(
                label: Text('Date'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
            ],
            rows: List.generate(
              length,
              (index) {
                // For each item in the attendanceData list, create a DataRow widget
                return DataRow(
                  cells: [
                    DataCell(Text(applicationController
                            .applicationlist['message']?[index]?["title"] ??
                        '')),
                    DataCell(Text(
                        applicationController.applicationlist['message']?[index]
                                ?["start_date"] ??
                            '')),
                    DataCell(Text(applicationController
                            .applicationlist['message']?[index]?["status"] ??
                        '')),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
