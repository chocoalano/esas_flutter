import 'dart:convert';
import 'package:get/get.dart';

import '../../../../../../../../components/widgets/snackbar.dart';
import '../../../../../../../networks/api/akun/api_auth.dart';

class PengalamanKerjaController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  var formData = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    addForm();
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
    return 0;
  }

  // Tambahkan form baru
  void addForm() {
    formData.add({
      'id': getLastId() + 1,
      'company_name': '',
      'position': '',
      'start': '',
      'finish': '',
      'certification': true,
    });
  }

  // Hapus form berdasarkan index jika lebih dari satu form
  Future<void> removeForm(int index) async {
    if (formData.length > 1) {
      formData.removeAt(index);
    }
  }

  // Update form berdasarkan key dan value
  void updateForm(int index, String key, dynamic value) {
    if (key == 'certification' && value is bool) {
      formData[index][key] = value;
    } else if (value is String) {
      formData[index][key] = value;
    }
    formData.refresh();
  }

  // Ambil data profil pengguna
  Future<void> getProfile() async {
    isLoading(true);
    try {
      final response = await provider.getProfile();
      if (response.statusCode == 200) {
        final formal = jsonDecode(response.body)['data']['work_experiences'];
        if (formal is List) {
          formData.clear();
          for (var e in formal) {
            formData.add({
              'id': e['id']?.toString() ?? (getLastId() + 1).toString(),
              'company_name': e['company_name'] ?? '',
              'position': e['position'] ?? '',
              'start': e['start'] ?? '',
              'finish': e['finish'] ?? '',
              'certification': e['lengthOfService'] ?? '',
            });
          }
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

  // Simpan profil ke server
  Future<void> saveWorkExperience() async {
    isLoading(true);
    try {
      final processedData = formData.map((item) {
        return {
          ...item,
          'certification': item['certification'] is bool
              ? item['certification']
              : item['certification'] == 'true',
        };
      }).toList();
      final response = await provider.saveWorkExperience(processedData);
      if (response.statusCode == 200) {
        showSuccessSnackbar('Data berhasil diperbarui');
      } else {
        showErrorSnackbar('Error: $response');
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
