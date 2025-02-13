import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../components/widgets/snackbar.dart';
import '../../../../support/support.dart';
import '../../../networks/api/beranda/api_absen.dart';
import 'absensi_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

class PhotoController extends GetxController {
  final ApiAbsen provider = Get.put(ApiAbsen());
  final AbsensiController absensiC = Get.put(AbsensiController());
  final initial = Get.arguments != null ? Get.arguments['initial'] : 'in';
  final timeId = Get.arguments['timeId'];

  CameraController? cameraController;
  var isCameraInitialized = false.obs;
  var capturedImagePath = ''.obs;

  var isLoadingApi = false.obs;
  var isWithinRange = false.obs;
  var currentDistance = 0.0.obs;
  var curLatitude = 0.0.obs;
  var curLongitude = 0.0.obs;

  final double targetLatitude = -6.175617390202554;
  final double targetLongitude = 106.59918387360153;
  final double rangeLimit = 200.0;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      CameraDescription? frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      showErrorSnackbar('Failed to initialize camera: ${e.toString()}');
    }
  }

  Future<Map<String, double>> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Periksa apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    // Periksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best, // Atur akurasi sesuai kebutuhan
      distanceFilter: 100, // Jarak dalam meter
    );
    // Jika izin diberikan, dapatkan posisi saat ini
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    curLatitude.value = position.latitude;
    curLongitude.value = position.longitude;
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }

  Future<void> capturePhoto() async {
    isLoadingApi(true);
    try {
      await _getCurrentLocation();
      if (cameraController == null || !cameraController!.value.isInitialized) {
        showErrorSnackbar('Kamera gagal dimuat!');
        return;
      }
      final directory = await getApplicationDocumentsDirectory();
      final imgName =
          '${DateTime.now().millisecondsSinceEpoch}.png'; // Nama gambar unik
      final path = join(directory.path, imgName);
      // Ambil gambar dan simpan ke path yang diinginkan
      XFile picture = await cameraController!.takePicture();
      await picture.saveTo(path);
      capturedImagePath.value = path;
      // Konversi RxString ke File
      final File file = File(capturedImagePath.value);
      // Kirim data absensi bersama koordinat saat ini
      initializeDateFormatting('id_ID', null);
      String formattedTime =
          DateFormat('HH:mm:ss', 'id_ID').format(DateTime.now());
      final datapost = {
        'time_id': timeId,
        'time': formattedTime,
        'type': initial,
        'date': formatDate(DateTime.now()),
        'lat': curLatitude.value.toString(),
        'long': curLongitude.value.toString(),
      };
      try {
        await provider.saveSubmit(datapost, file);
        absensiC.fetchCurrentAttendance();
        Get.offAllNamed('/beranda');
        showSuccessSnackbar('Data berhasil disimpan');
        isLoadingApi(false);
      } catch (e) {
        showErrorSnackbar("Terjadi kesalahan server : ${e.toString()}");
        Get.offAllNamed('/beranda');
        isLoadingApi(false);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error absen ${e.toString()}");
      }
      showErrorSnackbar(
          'Gagal mengambil atau mengunggah foto, pastikan esas mendapatkan izin untuk mengakses kamera. silahkan periksa akses izin aplikasi pada aperangkat anda!');
      isLoadingApi(false);
    }
  }
}
