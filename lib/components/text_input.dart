import '../constant.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final TextInputType inputType;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.inputType =
        TextInputType.text, // Default ke text jika tidak ditentukan
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType, // Menentukan tipe input
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
