import 'package:get/get.dart';

import '../../../../../networks/api/akun/api_auth.dart';
import '../controllers/info_personal_controller.dart';

class InfoPersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoPersonalController>(
      () => InfoPersonalController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
