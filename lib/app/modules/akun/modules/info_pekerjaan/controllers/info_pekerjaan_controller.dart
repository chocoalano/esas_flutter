import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../models/users/user_view.dart';
import '../../../../../networks/api/akun/api_auth.dart';

class InfoPekerjaanController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  var isloading = false.obs;
  var isBanner = true.obs;
  var profile = UserView().obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isloading(true);
    try {
      final response = await provider.getProfileDisplay();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print(fetch['data']);
      }
      profile.value = UserView.fromJson(fetch['data']);
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isloading(false);
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
