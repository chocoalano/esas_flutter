import 'package:get/get.dart';

import '../../../../../networks/api/beranda/api_beranda.dart';
import '../controllers/anouncement_detail_controller.dart';

class AnouncementDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnouncementDetailController>(
      () => AnouncementDetailController(),
    );
    Get.lazyPut<ApiBeranda>(
      () => ApiBeranda(),
    );
  }
}
