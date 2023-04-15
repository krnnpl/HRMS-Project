import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/company_controller.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var companyController = Get.put(CompanyController());

    return Center(
      child: Card(
        margin: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Image.network(
              "http://bmcdharan.edu.np/wp-content/uploads/2019/08/BMC-Dharan2aa.png",
              height: 140,
            ),
            Text(
                "Company name: ${companyController.company['message']?['company_name'] ?? ''}"),
            Text(
                "estd:  ${companyController.company['message']?['estd'] ?? ''}"),
            Text(
                "address: ${companyController.company['message']?['address'] ?? ''}"),
            Text(
                "Phone number: ${companyController.company['message']?['phone_number'] ?? ''}"),
            Text(
                "email: ${companyController.company['message']?['email'] ?? ''}"),
          ],
        ),
      ),
    );
  }
}
