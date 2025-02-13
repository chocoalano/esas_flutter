import 'package:get/get.dart';

import '../../../networks/api/akun/api_auth.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
