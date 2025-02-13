import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../components/widgets/snackbar.dart';
import '../../../../models/auth/user_detail.dart';
import '../../../../models/auth/work_schedule.dart';
import '../../../../models/setting.dart';
import '../../../../networks/api/akun/api_auth.dart';
import '../../../../networks/api/beranda/api_absen.dart';
import '../../../../networks/api/beranda/api_beranda.dart';
import '../../../absensi/controllers/absensi_controller.dart';
import '../../../absensi/controllers/gps_controller.dart';
import '../../../login/controllers/login_controller.dart';

class HomeController extends GetxController {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final ApiBeranda apiBeranda = Get.put(ApiBeranda());
  final ApiAbsen apiAbsenRepository = Get.put(ApiAbsen());
  final ApiAuth apiAuthRepository = Get.put(ApiAuth());
  var isLoading = false.obs;
  var userSchedule = WorkSchedule(
    id: null,
    userId: null,
    timeWorkId: null,
    workDay: null,
    createdAt: null,
    updatedAt: null,
    timeWork: null,
  ).obs;
  var userDetail = UserDetail(
    id: null,
    companyId: null,
    name: null,
    nip: null,
    email: null,
    emailVerifiedAt: null,
    avatar: null,
    status: null,
    deviceId: null,
    createdAt: null,
    updatedAt: null,
    details: null,
    address: null,
    salaries: null,
    families: null,
    formalEducations: null,
    informalEducations: null,
    workExperiences: null,
    employee: null,
  ).obs;
  var setting = Setting(
          attendanceImageGeolocation: false,
          attendanceQrcode: false,
          attendanceFingerprint: false)
      .obs;
  final gpsC = Get.put(GpsController());
  final absensiC = Get.put(AbsensiController());
  final loginC = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    setAccount();
    setSetting();
    fetchScheduleAttendance();
    gpsC.checkLocationPermission();
    absensiC.fetchCurrentAttendance();
  }

  Future<void> testNotification() async {
    await apiBeranda.testNotifRequest();
  }

  Future<void> setAccount() async {
    isLoading(true);
    try {
      final response = await apiAuthRepository.getProfile();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      userDetail.value = UserDetail.fromJson(fetch['data']);
      if (userDetail.value.deviceId == null) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        String? imei = androidInfo.id;
        await apiAuthRepository.setImei({"imei": imei});
      }
    } catch (e) {
      showErrorSnackbar("Error ketika memuat akun ${e.toString()}");
      logout();
    } finally {
      isLoading(false);
    }
  }

  Future<void> setSetting() async {
    isLoading(true);
    try {
      final response = await apiAuthRepository.getSetting();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print("========================= info data ${fetch['data']}");
      }
      setting.value = Setting.fromJson(fetch['data']);
    } catch (e) {
      showErrorSnackbar("Error ketika memuat akun ${e.toString()}");
      logout();
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    loginC.getLogout();
  }

  void fetchScheduleAttendance() async {
    try {
      final response = await apiAbsenRepository.fetchCurrentShift();
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      userSchedule.value = WorkSchedule.fromJson(jsonData['data']);
    } catch (e) {
      if (kDebugMode) {
        print(
            'Terjadi kesalahan pada controller home dengan pesan : ${e.toString()}');
      }
    }
  }
}
