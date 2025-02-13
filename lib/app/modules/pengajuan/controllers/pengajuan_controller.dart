import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/Permit/permit_type.dart';
import '../../../networks/api/pengajuan/api_permit.dart';

class PengajuanController extends GetxController {
  final ApiPermit provider = Get.find<ApiPermit>();
  var list = <PermitType>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMoreList();
  }

  Future<void> loadMoreList() async {
    isLoading.value = true;
    try {
      final response = await provider.listType();
      list.addAll(response);
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
