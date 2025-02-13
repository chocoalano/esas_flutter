import 'package:get/get.dart';

import '../../../../../../../networks/api/akun/api_auth.dart';
import '../controllers/pendidikan_formal_controller.dart';

class PendidikanFormalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunPendidikanFormalController>(
      () => AkunPendidikanFormalController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
