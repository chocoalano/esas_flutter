import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../../components/widgets/snackbar.dart';
import '../../../../../networks/api/akun/api_auth.dart';

class UbahPasswordController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final formKey = GlobalKey<FormBuilderState>();
  var isLoading = false.obs;
  // Method untuk submit form
  Future<void> submitForm() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final oldPassword = formKey.currentState?.fields['old_password']?.value;
      final newPassword = formKey.currentState?.fields['new_password']?.value;
      final confirmPassword =
          formKey.currentState?.fields['confirm_password']?.value;

      if (newPassword != confirmPassword) {
        showErrorSnackbar(
            'Error: Password baru dan konfirmasi password tidak cocok');
        return;
      }
      isLoading(true);
      try {
        final formData = {
          'password': oldPassword,
          'new_password': newPassword,
          'confirmation_new_password': confirmPassword
        };
        final response = await provider.saveSubmitPassword(formData);
        if (response.statusCode == 200) {
          showSuccessSnackbar('Data berhasil diperbarui');
        } else if (response.statusCode == 404) {
          showErrorSnackbar('Password lama anda tidak sesuai!');
        } else {
          showErrorSnackbar('Terjadi kesalahan, silahkan hubungi tim ICT!');
        }
      } catch (e) {
        showErrorSnackbar('Error: $e');
      } finally {
        isLoading(false);
      }
    } else {
      showErrorSnackbar('Form tidak valid');
    }
  }
}
