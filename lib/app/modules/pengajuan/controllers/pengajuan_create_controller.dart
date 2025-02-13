import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/auth/work_schedule.dart';
import '../../../models/validation_errors.dart';
import '../../../networks/api/akun/api_auth.dart';
import '../../../networks/api/pengajuan/api_permit.dart';

class PengajuanCreateController extends GetxController {
  final ApiAuth provider = Get.find<ApiAuth>();
  final ApiPermit providerPermit = Get.find<ApiPermit>();
  final formKey = GlobalKey<FormBuilderState>();

  var listJadwalKerja = <WorkSchedule>[].obs;
  var isLoading = false.obs;
  var showInfo = true.obs;
  var errorMessages = <String, String?>{}.obs;
  final selectedFile = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    loadSchedule();
  }

  Future<void> loadSchedule() async {
    _setLoading(true);
    try {
      final response = await provider.listJadwalKerja();
      listJadwalKerja.assignAll(response);
    } catch (e) {
      showErrorSnackbar('Gagal memuat jadwal kerja: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> selectFile() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedFile.value = File(image.path);
      }
    } catch (e) {
      showErrorSnackbar('Gagal memilih file: $e');
    }
  }

  void submitForm(int permitTypeId) async {
    if (!_validateForm()) return;

    _setLoading(true);

    final payload = _buildPayload(permitTypeId);
    try {
      final file = selectedFile.value;
      if (file == null) {
        await _submitWithoutFile(payload);
      } else {
        await _submitWithFile(payload, file);
      }
    } catch (e) {
      showErrorSnackbar('Terjadi kesalahan server: $e');
    } finally {
      _setLoading(false);
    }
  }

  bool _validateForm() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      return true;
    } else {
      showErrorSnackbar(
          'Periksa kembali form Anda. Pastikan semua field terisi dengan benar!');
      return false;
    }
  }

  Map<String, dynamic> _buildPayload(int permitTypeId) {
    final formData = formKey.currentState!.value;
    return {
      'type': 'mobile',
      'user_timework_schedule_id':
          formData['user_timework_schedule_id'].toString(),
      'start_date':
          (formData['start_date'] as DateTime).toIso8601String().split('T')[0],
      'end_date':
          (formData['end_date'] as DateTime).toIso8601String().split('T')[0],
      'start_time': (formData['start_time'] as DateTime)
          .toIso8601String()
          .split('T')[1]
          .substring(0, 8),
      'end_time': (formData['end_time'] as DateTime)
          .toIso8601String()
          .split('T')[1]
          .substring(0, 8),
      'notes': formData['notes'],
      'permit_type_id': permitTypeId.toString(),
    };
  }

  Future<void> _submitWithoutFile(Map<String, dynamic> payload) async {
    final response = await providerPermit.saveSubmitNotFile(payload);
    _handleResponse(response);
  }

  Future<void> _submitWithFile(Map<String, dynamic> payload, File file) async {
    final response = await providerPermit.saveSubmit(payload, file);
    _handleResponse(response);
  }

  void _handleResponse(dynamic response) {
    if (response.statusCode == 200) {
      showSuccessSnackbar('Pengajuan berhasil disimpan!');
    } else {
      selectedFile.value = null;
      final data = jsonDecode(response.body)['data'];
      if (data.containsKey('errors')) {
        _updateErrorMessages(data);
      } else {
        showErrorSnackbar('Kesalahan server: ${data.toString()}');
      }
    }
  }

  void _updateErrorMessages(Map<String, dynamic> data) {
    final validationErrors = ValidationErrors.fromJson(data);
    errorMessages.value = {
      "user_id": validationErrors.getError("user_id"),
      "permit_numbers": validationErrors.getError("permit_numbers"),
      "start_date": validationErrors.getError("start_date"),
      "end_date": validationErrors.getError("end_date"),
      "start_time": validationErrors.getError("start_time"),
      "end_time": validationErrors.getError("end_time"),
      "notes": validationErrors.getError("notes"),
    };
  }

  void _setLoading(bool value) {
    isLoading.value = value;
  }

  void hideAlert() {
    showInfo.toggle();
  }
}
