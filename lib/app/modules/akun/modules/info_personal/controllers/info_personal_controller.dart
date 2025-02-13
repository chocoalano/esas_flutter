import 'dart:convert';
import 'package:get/get.dart';

import '../../../../../../components/widgets/snackbar.dart';
import '../../../../../models/users/user_view.dart';
import '../../../../../networks/api/akun/api_auth.dart';

class InfoPersonalController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());
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
      if (response.statusCode == 200) {
        profile.value = UserView.fromJson(fetch['data']);
      } else {
        showErrorSnackbar(response.body);
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isloading(false);
    }
  }

  void showBanner() {
    isBanner.value = !isBanner.value;
  }
}
