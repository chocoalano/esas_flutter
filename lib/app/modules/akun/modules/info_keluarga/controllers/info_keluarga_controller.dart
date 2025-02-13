import 'dart:convert';
import 'package:get/get.dart';

import '../../../../../../components/widgets/snackbar.dart';
import '../../../../../networks/api/akun/api_auth.dart';

class InfoKeluargaController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();

  var formData = <Map<String, dynamic>>[]
      .obs; // Menggunakan dynamic untuk fleksibilitas data
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addForm(); // Menambahkan form kosong pada saat inisialisasi
    getProfile();
  }

  // Fungsi untuk mendapatkan ID terakhir dalam formData
  int getLastId() {
    if (formData.isNotEmpty) {
      // Mengambil ID terbesar dari formData
      return formData
          .map((e) => int.tryParse(e['id'].toString()) ?? 0)
          .reduce((a, b) => a > b ? a : b);
    }
    return 0; // Jika formData kosong, kembalikan 0
  }

  // Tambahkan form baru
  void addForm() {
    formData.add({
      'id': getLastId() + 1,
      'fullname': '',
      'relationship': '',
      'birthdate': '',
      'marital_status': '',
      'job': ''
    });
  }

  // Hapus form berdasarkan index jika lebih dari satu form
  Future<void> removeForm(int index) async {
    if (formData.length > 1) {
      formData.removeAt(index);
    }
  }

  Future<void> saveForm() async {
    try {
      isLoading(true);
      await provider.saveFamily(formData);
      showSuccessSnackbar('Data berhasil disimpan');
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update form berdasarkan key dan value
  void updateForm(int index, String key, dynamic value) {
    formData[index][key] = value;
    formData.refresh(); // Memperbarui UI setelah data diubah
  }

  // Ambil data profil pengguna
  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        final family = fetch['data']['families'];
        formData.clear();
        for (var contact in family) {
          formData.add({
            'id': contact['id']?.toString() ?? (getLastId() + 1).toString(),
            'fullname': contact['fullname'] ?? '',
            'relationship': contact['relationship'] ?? '',
            'birthdate': contact['birthdate'] ?? '',
            'marital_status': contact['maritalStatus'] ?? '',
            'job': contact['job'] ?? '',
          });
        }
      } else {
        showErrorSnackbar('Error: ${response.statusCode}');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
