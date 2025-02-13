import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/users/user_view.dart';
import '../../../networks/api/api_karyawan.dart';

class KaryawanController extends GetxController {
  final ApiKaryawan provider = Get.find<ApiKaryawan>();

  var listKaryawan = <UserView>[].obs; // List observable untuk data karyawan
  var isLoading = false.obs; // Untuk mengatur indikator loading
  final int limit = 10; // Jumlah item per halaman
  var page = 1.obs; // Halaman aktif
  var hasMore = true.obs; // Status untuk memuat data lebih banyak
  final search = TextEditingController(); // Controller untuk input pencarian

  @override
  void onInit() {
    super.onInit();
    loadMoreList(); // Memuat data saat controller diinisialisasi
  }

  void clearSearch() {
    search.clear();
    refreshData(); // Reset dan muat ulang data saat pencarian dihapus
  }

  Future<void> loadMoreList() async {
    if (isLoading.value || !hasMore.value) {
      return; // Hindari pemanggilan berulang jika sedang memuat
    }

    isLoading.value = true; // Tampilkan indikator loading

    try {
      // Memanggil API dengan parameter pencarian
      final response = await provider.fetchList(page.value, limit, search.text);

      // Jika jumlah data kurang dari limit, hentikan load lebih banyak
      if (response.length < limit) {
        hasMore.value = false;
      }

      listKaryawan.addAll(response); // Tambahkan data ke list
      page.value++; // Increment halaman
    } catch (e) {
      showErrorSnackbar(e.toString()); // Tampilkan error menggunakan snackbar
    } finally {
      isLoading.value = false; // Sembunyikan indikator loading
    }
  }

  Future<void> refreshData() async {
    page.value = 1; // Reset halaman ke 1
    hasMore.value = true; // Reset status pemuatan data
    listKaryawan.clear(); // Kosongkan data sebelumnya
    await loadMoreList(); // Muat ulang data
  }
}
