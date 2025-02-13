import 'package:get/get.dart';

import '../../../../../../../networks/api/akun/api_auth.dart';
import '../controllers/pengalaman_kerja_controller.dart';

class PengalamanKerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengalamanKerjaController>(
      () => PengalamanKerjaController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
