import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final Color fillColor;
  final double borderRadius;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.fillColor = const Color(0xFFEEEEEE), // default fill color
    this.borderRadius = 10.0,
  });

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),
      fillColor: fillColor,
      filled: true,
      prefixIcon: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(),
      validator: validator,
    );
  }
}
