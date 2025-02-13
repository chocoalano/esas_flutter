import 'package:get/get.dart';

class BotNavController extends GetxController {
  var pageIndex = 0.obs;

  Future<void> changePage(int i) async {
    pageIndex(i);

    switch (i) {
      case 0:
        Get.toNamed('/beranda');
        break;
      case 1:
        Get.toNamed('/karyawan');
        break;
      case 2:
        Get.toNamed('/pengajuan');
        break;
      case 3:
        Get.toNamed('/inbox');
        break;
      case 4:
        Get.toNamed('/akun');
        break;
    }
  }
}
