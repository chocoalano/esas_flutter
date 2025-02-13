import 'package:get/get.dart';

import '../../../networks/api/api_karyawan.dart';
import '../controllers/karyawan_controller.dart';

class KaryawanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KaryawanController>(
      () => KaryawanController(),
    );
    Get.lazyPut<ApiKaryawan>(
      () => ApiKaryawan(),
    );
  }
}
