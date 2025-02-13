import 'package:flutter/material.dart';

Widget buildEmptyMessage(String title, String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      const SizedBox(height: 8),
      Text(
        message,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
      ),
    ],
  );
}
