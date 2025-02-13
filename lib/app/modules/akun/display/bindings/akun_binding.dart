import 'package:get/get.dart';

import '../../../home/display/controllers/home_controller.dart';
import '../../../login/controllers/login_controller.dart';
import '../controllers/akun_controller.dart';

class AkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunController>(
      () => AkunController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
