import 'dart:convert';
import 'package:get/get.dart';

import '../../../../../../../../components/widgets/snackbar.dart';
import '../../../../../../../networks/api/akun/api_auth.dart';

class PendidikanInformalController extends GetxController {
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
      "id": getLastId() + 1,
      "institution": "",
      "start": "",
      "finish": "",
      "type": "day",
      "duration": 0,
      "status": "passed",
      "certification": true
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
      final formal = jsonDecode(response.body)['data']['informal_educations'];
      if (formal is List) {
        formData.clear();
        for (var e in formal) {
          formData.add({
            'id': e['id']?.toString() ?? (getLastId() + 1).toString(),
            "institution": e['institution'] ?? '',
            "start": e['start'] ?? '',
            "finish": e['finish'] ?? '',
            "type": e['type'] ?? '',
            "duration": e['duration'] ?? '',
            "status": e['status'] ?? '',
            'certification': e['certification'] is bool
                ? e['certification']
                : e['certification'] == 'true',
          });
        }
      }
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Simpan profil ke server
  Future<void> saveInformalEducation() async {
    try {
      isLoading(true);
      final processedData = formData.map((item) {
        return {
          ...item,
          'certification': item['certification'] is bool
              ? item['certification']
              : item['certification'] == 'true',
        };
      }).toList();
      await provider.saveInformalEducation(processedData);
      showSuccessSnackbar('Data berhasil disimpan');
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
