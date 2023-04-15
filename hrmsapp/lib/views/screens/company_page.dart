import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/company_controller.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var companyController = Get.put(CompanyController());

    if (companyController.isLoading.value == true) {
      return const CircularProgressIndicator.adaptive();
    } else {
      return Center(
        child: Card(
          margin: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Image.network(
                  "http://bmcdharan.edu.np/wp-content/uploads/2019/08/BMC-Dharan2aa.png",
                  height: 140,
                ),
              ),
              Card(
                shadowColor: Colors.purple,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Company name: ${companyController.company['message']?['company_name'] ?? ''}",
                          textScaleFactor: 1.1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "estd:  ${companyController.company['message']?['estd'] ?? ''}",
                          textScaleFactor: 1.1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "address: ${companyController.company['message']?['address'] ?? ''}",
                          textScaleFactor: 1.1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Phone number: ${companyController.company['message']?['phone_number'] ?? ''}",
                          textScaleFactor: 1.1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "email: ${companyController.company['message']?['email'] ?? ''}",
                          textScaleFactor: 1.1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
