import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../components/widgets/snackbar.dart';
import '../../../../models/users/user_view.dart';
import '../../../../networks/api/akun/api_auth.dart';
import '../../../login/controllers/login_controller.dart';

class AkunController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());
  final loginC = Get.put(LoginController());
  var profile = UserView().obs;
  var isLoading = false.obs;

  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfileDisplay();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      profile.value = UserView.fromJson(fetch['data']);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitAvatar(File file) async {
    try {
      final formData = {
        'nik': profile.value.nip,
      };
      final submit = await provider.saveChangeAvatar(formData, file);
      if (submit == 200) {
        getProfile();
        showSuccessSnackbar('Data berhasil diperbaharui');
      } else {
        showErrorSnackbar('Terjadi kesalahan server!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void movePage(String page) {
    Get.offAllNamed('/akun/$page');
  }

  void logout() {
    loginC.getLogout();
  }
}
