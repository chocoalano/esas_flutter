import 'package:get/get.dart';

import '../controllers/info_tambahan_controller.dart';

class InfoTambahanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoTambahanController>(
      () => InfoTambahanController(),
    );
  }
}
