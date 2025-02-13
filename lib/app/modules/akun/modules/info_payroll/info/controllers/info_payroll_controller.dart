import 'dart:convert';
import 'package:get/get.dart';

import '../../../../../../../components/widgets/snackbar.dart';
import '../../../../../../models/auth/user_detail.dart';
import '../../../../../../networks/api/akun/api_auth.dart';

class InfoPayrollController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  var isloading = false.obs;
  var visibilityBanner = true.obs;
  var userDetail = UserDetail().obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isloading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        userDetail.value = UserDetail.fromJson(fetch['data']);
      } else {
        showErrorSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isloading(false);
    }
  }

  void setBanner() {
    visibilityBanner.value = !visibilityBanner.value;
  }
}
