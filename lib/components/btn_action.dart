import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class BtnAction extends StatelessWidget {
  const BtnAction({
    super.key,
    required this.act,
    required this.color,
    required this.icon,
    required this.title,
    required this.isLoading,
  });

  final String title;
  final IconData icon;
  final VoidCallback act;
  final Color color;
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, secondaryColor], // Gradient colors
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            minimumSize: const Size(double.infinity, 50), // Block button
            backgroundColor: Colors.transparent, // Set to transparent
            shadowColor: Colors.transparent, // Remove the shadow
          ),
          onPressed:
              isLoading.value ? null : act, // Disable button when loading
          icon: isLoading.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Icon(icon, color: Colors.white),
          label: Text(
            isLoading.value ? 'Loading...' : title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
