import 'package:get/get.dart';

import '../../../networks/api/beranda/api_absen.dart';
import '../controllers/absensi_controller.dart';
import '../controllers/gps_controller.dart';
import '../controllers/list_controller.dart';
import '../controllers/photo_controller.dart';
import '../controllers/qr_code_controller.dart';

class AbsensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListController>(
      () => ListController(),
    );
    Get.lazyPut<GpsController>(
      () => GpsController(),
    );
    Get.lazyPut<PhotoController>(
      () => PhotoController(),
    );
    Get.lazyPut<AbsensiController>(
      () => AbsensiController(),
    );
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );
    Get.lazyPut<ApiAbsen>(
      () => ApiAbsen(),
    );
  }
}
