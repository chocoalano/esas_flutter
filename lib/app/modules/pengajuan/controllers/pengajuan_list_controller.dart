import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/Permit/permit_list.dart';
import '../../../models/Permit/permit_type.dart';
import '../../../networks/api/pengajuan/api_permit.dart';

class PengajuanListController extends GetxController {
  final ApiPermit provider = Get.find<ApiPermit>();
  var list = <PermitList>[].obs;

  var isLoading = false.obs;
  var isLoadingAct = false.obs;
  final int limit = 10;
  var page = 1.obs;
  var search = ''.obs;
  var hasMore = true.obs;

  Future<void> loadMoreList(int listTypeId) async {
    isLoading.value = true;
    try {
      final response = await provider.listPermit(
          page.value, limit, search.value, listTypeId);
      if (response.length < limit) {
        hasMore.value = false;
      }
      list.addAll(response);
      // print("============================response : $response");
    } catch (e) {
      if (kDebugMode) {
        print("=====================>>>>>>>>>error : $e");
      }
      // showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> shortOnNeedApproved(int listTypeId) async {
    search('w');
    await refreshData(listTypeId);
  }

  Future<void> refreshData(int listTypeId) async {
    search('');
    page.value = 1;
    hasMore.value = true;
    list.clear();
    await loadMoreList(listTypeId);
  }

  Future<void> approved(
      int id, String status, String notes, PermitType permitType) async {
    try {
      isLoadingAct(true);
      await provider.approval(id, status, notes);
      if (Get.currentRoute == 'pengajuan/cuti/show') {
        refreshData(permitType.id);
        Get.offAllNamed('pengajuan/cuti', arguments: permitType);
      }
      if (Get.currentRoute == 'pengajuan/cuti') {
        refreshData(permitType.id);
      }
      showSuccessSnackbar('Tanggapan disimpan.');
    } catch (e) {
      if (kDebugMode) {
        print("=================error approve : $e");
      }
      showErrorSnackbar('Terjadi kesalahan pada aplikasi');
    } finally {
      isLoadingAct(false);
    }
  }
}
