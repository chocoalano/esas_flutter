import 'package:flutter/material.dart';

import '../constant.dart';

InputDecoration formInput({required String label, required IconData icon}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    fillColor: primaryColor.withOpacity(0.1),
    filled: true,
    labelText: label,
    prefixIcon: Icon(
      icon,
      color: primaryColor,
    ),
  );
}

InputDecoration formTextAreaInput({required String label}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    fillColor: primaryColor.withOpacity(0.1),
    filled: true,
    labelText: label,
    alignLabelWithHint: true, // Align the label at the top for multiline fields
    floatingLabelBehavior:
        FloatingLabelBehavior.always, // Ensure the label stays on top
    contentPadding: const EdgeInsets.symmetric(
        vertical: 16, horizontal: 12), // Add padding for better spacing
  );
}
