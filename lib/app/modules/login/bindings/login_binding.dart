import 'package:get/get.dart';

import '../../../networks/api/akun/api_auth.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
