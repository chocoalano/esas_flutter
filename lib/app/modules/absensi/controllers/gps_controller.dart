import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/auth/office.dart';
import '../../../networks/api/beranda/api_absen.dart';

class GpsController extends GetxController {
  final ApiAbsen provider = ApiAbsen();
  var isLoading = false.obs;
  var isWithinRange = false.obs;
  var currentDistance = 0.0.obs;
  var isMockedLocation = false.obs;
  var office = Office(
    id: null,
    name: null,
    latitude: 0.0,
    longitude: 0.0,
    radius: 0,
    fullAddress: null,
    createdAt: null,
    updatedAt: null,
  ).obs;

  // RxDouble targetLatitude = 0.0.obs;
  // RxDouble targetLongitude = 0.0.obs;
  // RxDouble rangeLimit = 0.0.obs;

  StreamSubscription<Position>? positionStream;

  @override
  void onClose() {
    positionStream?.cancel(); // Cancel the stream when the controller is closed
    super.onClose();
  }

  void checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showErrorSnackbar('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showErrorSnackbar('Location permissions are permanently denied');
      return;
    }
    getLocationData();
  }

  Future<void> getLocationData() async {
    isLoading.value = true;
    try {
      final response = await provider.fetchLocationAbsen();
      final fetch = jsonDecode(response.body) as Map<String, dynamic>;
      office.value = Office.fromJson(fetch['data']);

      // Start location stream only if valid data is present
      if (office.value.latitude != 0.0 &&
          office.value.longitude != 0.0 &&
          office.value.radius != 0) {
        _startLocationStream();
      } else {
        showErrorSnackbar('Data lokasi absen tidak berhasil dimuat');
      }
    } catch (e) {
      showErrorSnackbar("error di controller gps boss ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void _startLocationStream() {
    // Jika stream sudah ada, batalkan dulu untuk menghindari multiple listeners
    positionStream?.cancel();

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((Position position) async {
      // Menghitung jarak antara posisi saat ini dan target
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        office.value.latitude!,
        office.value.longitude!,
      );

      // Periksa apakah lokasi menggunakan mock
      final mockDetected = await isMockLocation(position);

      // Memperbarui jarak saat ini dan status apakah dalam jangkauan
      currentDistance.value = distance;
      isWithinRange.value = distance <= office.value.radius!;
      isMockedLocation.value = mockDetected;

      if (mockDetected) {
        showErrorSnackbar('Fake GPS terdeteksi! Harap matikan lokasi palsu.');
        positionStream?.cancel(); // Stop stream to prevent further updates
      }
    });
  }

  Future<bool> isMockLocation(Position position) async {
    // Properti isMocked mendeteksi lokasi palsu
    return position.isMocked;
  }
}
