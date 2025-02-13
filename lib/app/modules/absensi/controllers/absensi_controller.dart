import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../../services/notif_service.dart';
import '../../../models/attendance/current_attendance.dart';
import '../../../models/auth/timework.dart';
import '../../../networks/api/beranda/api_absen.dart';

class AbsensiController extends GetxController {
  final NotifService notifService = Get.put(NotifService());
  final ApiAbsen provider = Get.put(ApiAbsen());
  var isLoading = false.obs;
  var btnIn = false.obs;
  var btnOut = false.obs;
  var listTime = <TimeWork>[].obs;
  var timeId = Rxn<String>();
  var showAlert = false.obs;
  var currentAttendance = CurrentAttendance().obs;

  Rx<int?> selectedShift = Rx<int?>(null);

  void fetchCurrentAttendance() async {
    isLoading.value = true;
    try {
      final response = await provider.fetchCurrentAbsen();
      if (response.statusCode == 200) {
        final fetch = jsonDecode(response.body) as Map<String, dynamic>;
        currentAttendance.value = CurrentAttendance.fromJson(fetch['data']);
        btnIn.value = currentAttendance.value.timeIn != null ? true : false;
        btnOut.value = currentAttendance.value.timeOut != null ? true : false;
      }
    } on SocketException catch (_) {
      showErrorSnackbar('Waktu jaringan habis. Silahkan coba dilain waktu.');
    } catch (e) {
      if (kDebugMode) {
        print("Errornya difungsi pas get absen hari ini ${e.toString()}");
      }
      notifService.showNotification(
          'Absensi', 'Anda belum melakukan absen hari ini');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchListTime() async {
    isLoading(true);
    try {
      List<TimeWork> response = await provider.fetchListTimeAbsen();
      listTime.clear();
      listTime.addAll(response);
    } catch (e) {
      showErrorSnackbar(
          "Sistem tidak bisa mendeteksi daftar jam kerja anda, hal ini dikarnakan kami tidak memiliki data mengenai Departemen, Jabatan, dan level anda sebagai pekerja. silahkan hubungi Tim HRGA untuk membantu anda melengkapi data diri anda. Terimakasih.");
    } finally {
      isLoading(false);
    }
  }
}
