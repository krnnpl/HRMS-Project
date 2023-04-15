import 'package:flutter/material.dart';

typedef MyCallback = void Function(String);

class CustomTextField extends StatelessWidget {
  final TextEditingController mycontroller;
  final String labelText;
  const CustomTextField(
      {super.key, required this.labelText, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: mycontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
