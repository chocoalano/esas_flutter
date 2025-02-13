import 'package:get/get.dart';

import '../../../../../../components/widgets/snackbar.dart';
import '../../../../../models/Tools/bug_reports.dart';
import '../../../../../networks/api/akun/api_auth.dart';

class BugsReportController extends GetxController {
  final ApiAuth provider = Get.put(ApiAuth());

  var list = <BugReports>[].obs;
  var isLoading = false.obs;
  final int limit = 10;
  var page = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMoreList();
  }

  Future<void> loadMoreList() async {
    if (isLoading.value || !hasMore.value) {
      return;
    }

    isLoading.value = true;
    try {
      final response = await provider.bugReportsList(page.value, limit, '');
      if (response.length < limit) {
        hasMore.value = false;
      }

      list.addAll(response);
      page.value++;
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    page.value = 1;
    hasMore.value = true;
    list.clear();
    await loadMoreList();
  }
}
