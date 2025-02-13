import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../components/widgets/snackbar.dart';
import '../../../../../networks/api/akun/api_auth.dart';

class BugReportsFormController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final formKey = GlobalKey<FormBuilderState>();
  final pickedImage = Rxn<File>();
  var isLoading = false.obs;
  var alert = true.obs;
  // Image picker function
  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void showHideAlert() {
    alert.value = !alert.value;
  }

  // Submit form
  Future<void> submitForm() async {
    if (pickedImage.value == null) {
      showErrorSnackbar('Silakan pilih gambar bukti terlebih dahulu');
      return;
    }
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final formData = formKey.currentState!.value;
      final data = {...formData};
      try {
        isLoading(true);
        final response =
            await provider.saveSubmitBugReports(data, pickedImage.value!);
        if (response == 200) {
          showSuccessSnackbar('Bug report submitted successfully!');
          Get.offAllNamed('/akun/info-report-bugs');
        } else {
          showErrorSnackbar('Terjadi kesalahan server!');
        }
      } catch (e) {
        showErrorSnackbar('Error: ${e.toString()}');
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar('Validation Failed', 'Please fill in all required fields.');
    }
  }
}
