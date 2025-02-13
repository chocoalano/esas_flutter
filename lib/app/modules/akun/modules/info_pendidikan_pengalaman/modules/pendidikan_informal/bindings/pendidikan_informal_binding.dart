import 'package:get/get.dart';

import '../../../../../../../networks/api/akun/api_auth.dart';
import '../controllers/pendidikan_informal_controller.dart';

class PendidikanInformalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendidikanInformalController>(
      () => PendidikanInformalController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
