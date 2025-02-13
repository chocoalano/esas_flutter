import 'package:flutter/material.dart';

import '../constant.dart';

class DatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final VoidCallback onTap;

  const DatePicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true, // Prevents manual input
      onTap: onTap, // Opens date picker when tapped
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
