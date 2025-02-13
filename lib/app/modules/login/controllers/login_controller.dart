import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../networks/api/akun/api_auth.dart';

class LoginController extends GetxController {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final formKey = GlobalKey<FormBuilderState>();
  final ApiAuth provider = Get.put(ApiAuth());
  final storage = GetStorage();
  final loading = false.obs;
  final isAuth = false.obs;

  Future<void> autoLogin() async {
    loading(true);
    try {
      final indicatour = storage.read('auth_indicatour');
      final password = storage.read('auth_password');
      login(indicatour, password);
    } catch (e) {
      Get.offAllNamed('/login');
    } finally {
      loading(false);
    }
  }

  Future<void> login(String indicatour, String password) async {
    loading(true);
    try {
      // Ambil informasi perangkat
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String? imei = androidInfo.id;

      // Kirim permintaan login ke API dengan timeout
      final response = await provider.submitLogin({
        'indicatour': indicatour,
        'password': password,
        'device_info': imei
      }).timeout(const Duration(seconds: 15)); // Timeout 15 detik

      if (response.statusCode == 200) {
        try {
          // Decode response body
          final fetch = jsonDecode(response.body) as Map<String, dynamic>;
          final info = fetch['data'];

          // Simpan token dan info pengguna
          setStorage(info['token'], info['token_type'], info['name'],
              info['userId'], indicatour, password);

          // Navigasi ke halaman beranda
          Get.offAllNamed('/beranda');
        } catch (e) {
          showErrorSnackbar(
              'Terjadi kesalahan saat memproses data dari server.');
          if (kDebugMode) {
            print("==============>>>>>> error parsing JSON: ${e.toString()}");
          }
        }
      } else {
        // Tangani error berdasarkan status kode HTTP
        switch (response.statusCode) {
          case 400:
            showErrorSnackbar(
                'Permintaan tidak valid. Silakan periksa kembali data yang Anda masukkan.');
            break;
          case 401:
            showErrorSnackbar('Akun atau password salah. Coba lagi.');
            break;
          case 403:
            showErrorSnackbar(
                'Akses ditolak. Anda tidak memiliki izin untuk masuk.');
            break;
          case 404:
            showErrorSnackbar('Server tidak ditemukan. Coba lagi nanti.');
            break;
          case 500:
            showErrorSnackbar(
                'Terjadi kesalahan di server. Silakan coba beberapa saat lagi.');
            break;
          default:
            showErrorSnackbar(
                'Login gagal: ${response.statusCode}. Silakan coba lagi nanti.');
            break;
        }
        if (kDebugMode) {
          print("==============>>>>>> error response: ${response.body}");
        }
      }
    } on SocketException {
      showErrorSnackbar(
          'Tidak ada koneksi internet. Periksa jaringan Anda dan coba lagi.');
    } on TimeoutException {
      showErrorSnackbar(
          'Koneksi ke server terlalu lama. Silakan coba lagi nanti.');
    } on FormatException {
      showErrorSnackbar('Terjadi kesalahan saat memproses data dari server.');
    } catch (e) {
      showErrorSnackbar(
          'Kombinasi NIP/email/Device IMEI dengan password Anda tidak dikenali! Jika Anda menggunakan perangkat baru, silakan hubungi Dept HR untuk mendaftarkan perangkat Anda.');
      if (kDebugMode) {
        print("==============>>>>>> error api : ${e.toString()}");
      }
    } finally {
      loading(false);
    }
  }

  Future<void> getLogout() async {
    await provider.submitLogout({});
    clearStorage();
    Get.offAllNamed('/login');
  }

  void setStorage(String token, String tokenType, String nameAuth, int userId,
      String authIndicatour, String authPassword) {
    storage.write('token', token);
    storage.write('token_type', tokenType);
    storage.write('name', nameAuth);
    storage.write('userId', userId);
    storage.write('auth_indicatour', authIndicatour);
    storage.write('auth_password', authPassword);
  }

  void clearStorage() {
    storage.remove('token');
    storage.remove('token_type');
    storage.remove('name');
    storage.remove('userId');
    storage.remove('auth_indicatour');
    storage.remove('auth_password');
  }
}
