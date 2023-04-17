import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/controller/applicationlist_controller.dart';
import 'package:hrmsapp/views/screens/send_application.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    var applicationController = Get.put(ApplicationListController());
    var length = applicationController.applicationlist['message']?.length ?? 0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: Get.size.width,
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: Get.size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () => Get.to(const SendApplication()),
                    child: const Text(
                      "Send Application ",
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.size.width * 0.1,
                ),
                ElevatedButton(
                  onPressed: () {
                    applicationController.fetchApplicationList();
                    setState(() {});
                  },
                  child: const Text("Refresh"),
                )
              ],
            ),
          ),
        ),
        Obx(() {
          if (applicationController.isLoading.value == true) {
            return const CircularProgressIndicator.adaptive();
          } else {
            return SizedBox(
              width: Get.size.width,
              child: DataTable(
                sortAscending: true,
                columns: const [
                  DataColumn(
                    label: Text('Title'),
                  ),
                  DataColumn(
                    label: Text('Status'),
                  ),
                  DataColumn(
                    label: Text('View'),
                  ),
                ],
                rows: List.generate(
                  length,
                  (index) {
                    // For each item in the attendanceData list, create a DataRow widget
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          applicationController.applicationlist['message']
                                  ?[index]?["title"] ??
                              '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text(
                          applicationController.applicationlist['message']
                                  ?[index]?["status"] ??
                              '',
                        )),
                        DataCell(IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Date : ${applicationController.applicationlist['message']?[index]?["start_date"] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Title : ${applicationController.applicationlist['message']?[index]?["title"] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    height: 300,
                                    width: Get.size.width,
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "Reason : \n${applicationController.applicationlist['message']?[index]?["reason"] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Days : ${applicationController.applicationlist['message']?[index]?["days"] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Status : ${applicationController.applicationlist['message']?[index]?["status"] ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                        ))
                      ],
                    );
                  },
                ),
              ),
            );
          }
        })
      ],
    );
  }
}
