import 'package:get/get.dart';

import '../../../../../components/widgets/snackbar.dart';
import '../../../../models/announcement/detail.dart';
import '../../../../networks/api/beranda/api_beranda.dart';

class AnouncementController extends GetxController {
  final ApiBeranda provider = Get.put(ApiBeranda());
  final int limit = 15;
  int page = 1;
  var hasMore = true.obs;
  var list = <Detail>[].obs;

  Future loadMoreList() async {
    try {
      List<Detail> response = await provider.announcementRequest(page, limit);
      if (response.length < limit) {
        hasMore.value = false;
      }

      list.addAll(response);
      page++;
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  Future refreshData() async {
    page = 1;
    hasMore.value = true;
    list.value = [];
    await loadMoreList();
  }
}
