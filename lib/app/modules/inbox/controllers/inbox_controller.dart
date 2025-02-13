import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/notification/notification_model.dart';
import '../../../networks/api/api_inbox.dart';

class InboxController extends GetxController {
  final ApiInbox provider = Get.find<ApiInbox>();

  var list = <NotificationModel>[].obs; // Daftar pemberitahuan
  var isLoading = false.obs; // Status loading umum (pagination)
  var isRefreshing = false.obs; // Status refresh data
  final int limit = 10; // Jumlah data per halaman
  var page = 1.obs; // Halaman data yang dimuat
  var hasMore = true.obs; // Status apakah ada data lebih lanjut

  @override
  void onInit() {
    super.onInit();
    loadMoreList();
  }

  /// Memuat lebih banyak data (pagination)
  Future<void> loadMoreList() async {
    if (isLoading.value || !hasMore.value) {
      return; // Jika sedang loading atau tidak ada data lagi
    }
    isLoading.value = true;
    try {
      final response = await provider.fetchPaginate(page.value, limit);
      if (response.length < limit) {
        hasMore.value = false; // Tidak ada data lagi
      }
      list.addAll(response); // Menambahkan data baru ke dalam daftar
      page.value++;
    } catch (e) {
      showErrorSnackbar('Gagal memuat data: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh data (memuat ulang dari awal)
  Future<void> refreshData() async {
    if (isRefreshing.value) return; // Mencegah refresh berulang
    isRefreshing.value = true;
    try {
      page.value = 1;
      hasMore.value = true;
      final response = await provider.fetchPaginate(page.value, limit);
      list.assignAll(response); // Mengganti seluruh data dengan yang baru
      page.value++;
    } catch (e) {
      if (kDebugMode) {
        print("=====================>>>>>>>>>>>> error refresh : $e");
      }
      showErrorSnackbar('Gagal me-refresh data: ${e.toString()}');
    } finally {
      isRefreshing.value = false;
    }
  }

  /// Menandai pemberitahuan sebagai sudah dibaca
  Future<void> read(String notifId) async {
    try {
      final response = await provider.isread(notifId);
      if (response == 200) {
        final index = list.indexWhere((notif) => notif.id == notifId);
        if (index != -1) {
          list[index] = list[index].copyWith(readAt: DateTime.now());
          list.refresh(); // Memperbarui UI secara reaktif
        }
      } else {
        showErrorSnackbar(
            'Terjadi kesalahan server ketika membaca pemberitahuan!');
      }
    } catch (e) {
      showErrorSnackbar(
          'Gagal menandai pemberitahuan sebagai dibaca: ${e.toString()}');
    }
  }

  /// Membersihkan seluruh data pemberitahuan
  Future<void> clearData() async {
    isLoading.value = true;
    try {
      final response = await provider.clear();
      if (response == 200) {
        list.clear();
        hasMore.value = false; // Tidak ada data lagi setelah clear
      } else {
        showErrorSnackbar(
            'Terjadi kesalahan server ketika membersihkan pemberitahuan!');
      }
    } catch (e) {
      showErrorSnackbar('Gagal membersihkan pemberitahuan: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
