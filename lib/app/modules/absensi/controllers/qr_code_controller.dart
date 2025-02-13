import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../networks/api/beranda/api_absen.dart';
import 'absensi_controller.dart';
import 'gps_controller.dart';

class QrCodeController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController(
    autoStart: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  final RxMap<String, dynamic> qrData = <String, dynamic>{}.obs;
  final RxString errorMessage = ''.obs;
  final isLoading = false.obs;
  final isScanning =
      true.obs; // Tambahkan flag untuk mencegah scanning berulang

  final GpsController gpsC = Get.put(GpsController());
  final AbsensiController absensiC = Get.put(AbsensiController());
  final ApiAbsen provider = Get.put(ApiAbsen());

  @override
  void onInit() {
    super.onInit();
    requestCameraPermission();
  }

  /// **Meminta Izin Kamera**
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      Future.delayed(Duration(milliseconds: 500), () {
        // Hindari error dengan delay
        if (isScanning.value) scannerController.start();
      });
    } else {
      errorMessage.value = "Izin kamera diperlukan untuk scanning QR Code.";
      Get.snackbar("Izin Diperlukan", errorMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// **Menangani Hasil Scan QR Code**
  void handleBarcode(BarcodeCapture capture) {
    if (!isScanning.value) return; // Mencegah scanning berulang

    final String? rawValue = capture.barcodes.firstOrNull?.rawValue;
    if (rawValue != null) {
      try {
        final Map<String, dynamic> jsonData = jsonDecode(rawValue);
        qrData.value = jsonData;
        errorMessage.value = '';
        isScanning.value = false; // Hentikan sementara scanning

        submit(qrData['type'], qrData['token']);
      } catch (e) {
        errorMessage.value = "QR Code tidak valid (harus JSON)";
        Get.snackbar("Error", errorMessage.value,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  /// **Mengirim Data QR ke Server**
  Future<void> submit(String type, String token) async {
    final datapost = {'type': type, 'token': token};
    if (kDebugMode) {
      print("=======>>>>>>>>> datapost qr: $datapost");
    }

    try {
      isLoading(true);
      await provider.submitQRcode(datapost);
      absensiC.fetchCurrentAttendance();
      showSuccessSnackbar('Data berhasil disimpan');
    } catch (e) {
      final errorMessage = _extractErrorMessage(e.toString());

      try {
        Map<String, dynamic> jsonResponse = jsonDecode(errorMessage);
        String errorText = jsonResponse['message'] ?? "Terjadi kesalahan.";

        if (jsonResponse.containsKey('data') &&
            jsonResponse['data'] is Map &&
            jsonResponse['data'].containsKey('error')) {
          errorText = jsonResponse['data']['error'].toString();
        }

        showErrorSnackbar(
            "Terjadi kesalahan: $errorText, hal ini bisa terjadi apabila anda melakukan absen pulang namun anda belum melakukan absen masuk, atau anda melakukan scan pada kode QR yang tidak valid!");
      } catch (_) {
        showErrorSnackbar("Terjadi kesalahan server.");
      }
    } finally {
      gpsC.getLocationData();
      isLoading(false);
      Future.delayed(Duration(seconds: 2), () => isScanning.value = true);
      Get.offAllNamed('/beranda');
    }
  }

  /// **Ekstrak Pesan Error dari Exception**
  String _extractErrorMessage(String exceptionString) {
    final startIdx = exceptionString.indexOf('{');
    return startIdx == -1 ? "{}" : exceptionString.substring(startIdx);
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
