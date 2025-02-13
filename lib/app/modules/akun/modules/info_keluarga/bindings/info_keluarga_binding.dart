import 'package:get/get.dart';
import '../../../../../networks/api/akun/api_auth.dart';
import '../controllers/info_keluarga_controller.dart';

class InfoKeluargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoKeluargaController>(
      () => InfoKeluargaController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
