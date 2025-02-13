import 'dart:convert';
import 'package:get/get.dart';

import '../../../../../../../../components/widgets/snackbar.dart';
import '../../../../../../../networks/api/akun/api_auth.dart';

class AkunPendidikanFormalController extends GetxController {
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
      'institution': '',
      'majors': '',
      'score': '',
      'start': '',
      'finish': '',
      'status': '',
      'certification': false,
    });
  }

  // Hapus form berdasarkan index jika lebih dari satu form
  Future<void> removeForm(int index) async {
    if (formData.length <= 1) return;
    formData.removeAt(index);
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
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        if (fetch['data']['formal_educations'] is List) {
          formData.clear();
          for (var e in fetch['data']['formal_educations']) {
            formData.add({
              'id': e['id']?.toString() ?? (getLastId() + 1).toString(),
              'institution': e['institution'] ?? '',
              'majors': e['majors'] ?? '',
              'score': e['score'].toString(),
              'start': e['start'] ?? '',
              'finish': e['finish'] ?? '',
              'status': e['status'] ?? 'passed',
              'certification': e['certification'] is bool
                  ? e['certification']
                  : e['certification'] == 'true',
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
  Future<void> saveFormalEducation() async {
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
      await provider.saveFormalEducation(processedData);
      showSuccessSnackbar('Data berhasil disimpan');
    } catch (e) {
      showErrorSnackbar('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
