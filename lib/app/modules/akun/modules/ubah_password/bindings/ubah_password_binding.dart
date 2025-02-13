import 'package:get/get.dart';

import '../../../../../networks/api/akun/api_auth.dart';
import '../controllers/ubah_password_controller.dart';

class UbahPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPasswordController>(
      () => UbahPasswordController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
