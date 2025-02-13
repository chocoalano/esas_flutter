import 'package:get/get.dart';
import '../../../../../networks/api/akun/api_auth.dart';
import '../controllers/info_pekerjaan_controller.dart';

class InfoPekerjaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoPekerjaanController>(
      () => InfoPekerjaanController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
