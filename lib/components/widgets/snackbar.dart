import '../../constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

showWarningSnackbar(String message) {
  Get.snackbar(
    'Warning',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: warningColor,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

showSuccessSnackbar(String message) {
  Get.snackbar(
    'Success',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: primaryColor,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}
