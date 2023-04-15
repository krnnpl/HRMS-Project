import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Employee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme.of(context).copyWith(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.purple),
          backgroundColor: Colors.white,
          elevation: 0.7,
          titleTextStyle: const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: false,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}