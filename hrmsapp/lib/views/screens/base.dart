import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmsapp/views/screens/account_page.dart';
import 'package:hrmsapp/views/screens/applications_page.dart';
import 'package:hrmsapp/views/screens/company_page.dart';
import 'package:hrmsapp/views/screens/home_page.dart';
import 'package:hrmsapp/views/screens/payroll_page.dart';
import 'package:hrmsapp/views/screens/settings_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  static int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Employee App"),
          leading: const Icon(Icons.people),
          actions: [
            IconButton(
              splashRadius: 20,
              splashColor: Colors.purple[200],
              onPressed: () {
                Get.to(const AccountPage());
                // Get.to(const AccountPage());
              },
              icon: const Icon(
                Icons.account_circle,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          showUnselectedLabels: true,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
              ),
              label: "Payroll",
              tooltip: "Payroll",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.wysiwyg,
              ),
              label: "Application",
              tooltip: "Application",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info_outline,
              ),
              label: "Company",
              tooltip: "Company",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: "Settings",
              tooltip: "Settings",
            ),
          ],
        ),
        body: (currentIndex == 0)
            ? const HomePage()
            // ? const HomePage()
            : (currentIndex == 1)
                ? const PayrollPage()

                // ? const PayrollPage()
                : (currentIndex == 2)
                    ? const ApplicationsPage()

                    // ? const ApplicationPage()
                    : (currentIndex == 3)
                        ? const CompanyPage()
                        // : Text("Settings")

                        // ? const CompanyPage()
                        : const SettingsPage(),
      ),
    );
  }
}
