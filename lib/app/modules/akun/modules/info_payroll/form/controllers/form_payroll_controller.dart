// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../../../components/widgets/snackbar.dart';
import '../../../../../../networks/api/akun/api_auth.dart';

class FormPayrollController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final formKey = GlobalKey<FormBuilderState>();

  var isLoading = false.obs;
  var bank_name = ''.obs;
  var bank_number = ''.obs;
  var bank_holder = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        final data = fetch['data']['employee'];
        if (formKey.currentState != null) {
          formKey.currentState!.patchValue(data);
        } else {
          bank_name.value = data['bank_name'] ?? '';
          bank_number.value = data['bank_number'] ?? '';
          bank_holder.value = data['bank_holder'] ?? '';
        }
      } else {
        showErrorSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    }
  }

  // Simpan data saat form disubmit
  Future<void> onSubmit() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      // Ambil nilai dari form
      final formData = formKey.currentState!.value;

      // Simpan ke state
      bank_name.value = formData['bank_name'];
      bank_number.value = formData['bank_number'];
      bank_holder.value = formData['bank_holder'];
      Map<String, dynamic> datapost = {
        "bank_name": bank_name.value,
        "bank_number": bank_number.value,
        "bank_holder": bank_holder.value,
      };
      try {
        await provider.saveSubmitBank(datapost);
      } catch (e) {
        showErrorSnackbar('Tolong lengkapi dulu form anda!');
      }
      // Tampilkan hasil atau kirim ke server
      showSuccessSnackbar('Bank info updated successfully!');
    } else {
      showErrorSnackbar('Tolong lengkapi dulu form anda!');
    }
  }
}
