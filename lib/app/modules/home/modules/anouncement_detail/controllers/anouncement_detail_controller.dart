import 'package:get/get.dart';

import '../../../../../../components/widgets/snackbar.dart';
import '../../../../../models/announcement/detail.dart';
import '../../../../../networks/api/beranda/api_beranda.dart';

class AnouncementDetailController extends GetxController {
  final ApiBeranda provider = Get.put(ApiBeranda());
  late final int id;
  var isLoading = false.obs;
  var announcementDetail = Detail().obs;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    showDetail();
  }

  void showDetail() async {
    try {
      isLoading(true);
      final response = await provider.announcementRequestDetail(id);
      announcementDetail.value = response;
    } catch (e) {
      showErrorSnackbar('Terjadi kesalahan server Error : ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
