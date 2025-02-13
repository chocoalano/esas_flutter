import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../constant.dart';
import '../../../../../../support/style.dart';
import '../../../../../../support/typography.dart';
import '../../../../absensi/controllers/absensi_controller.dart';
import '../../../../absensi/controllers/gps_controller.dart';
import '../../controllers/home_controller.dart';

class Absencard extends StatelessWidget {
  const Absencard({super.key});

  @override
  Widget build(BuildContext context) {
    final GpsController gpsC = Get.put(GpsController());
    final AbsensiController absensiC = Get.put(AbsensiController());
    final homeController = Get.put(HomeController());

    absensiC.fetchCurrentAttendance();

    absensiC.fetchListTime();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Jadwal kerja sekarang',
                    style: textRowBoldSm,
                  )
                ],
              ),
              const Divider(),
              Obx(() => _buildTextRow('Jadwal Jam kerja',
                  homeController.userSchedule.value.timeWork?.name ?? '...')),
              Obx(() => _buildTextRow(
                  'Jam masuk',
                  homeController.userSchedule.value.timeWork?.inTime ??
                      '--:--:--')),
              Obx(() => _buildTextRow(
                  'Jam pulang',
                  homeController.userSchedule.value.timeWork?.outTime ??
                      '--:--:--')),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => _buildTimeText(
                      absensiC.currentAttendance.value.timeIn ?? '--:--:--',
                      absensiC.currentAttendance.value.statusIn == 'late'
                          ? false
                          : true)),
                  Obx(() => gpsC.isLoading.isFalse
                      ? IconButton.outlined(
                          onPressed: () => gpsC.checkLocationPermission(),
                          icon: Icon(Icons.refresh))
                      : const CircularProgressIndicator(color: primaryColor)),
                  Obx(() => _buildTimeText(
                      absensiC.currentAttendance.value.timeOut ?? '--:--:--',
                      absensiC.currentAttendance.value.statusOut == 'late'
                          ? false
                          : true)),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() =>
                  homeController.setting.value.attendanceImageGeolocation ==
                          true
                      ? DropdownButtonFormField(
                          value: absensiC.timeId.value,
                          items: absensiC.listTime
                              .map((time) => DropdownMenuItem(
                                    value: time.id.toString(),
                                    child: Text(
                                        "${time.name} jam: ${time.inTime}-${time.outTime}"),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            absensiC.timeId.value = value;
                          },
                          decoration: formInput(
                            label: 'Pilih jam kerja',
                            icon: Icons.timer_outlined,
                          ),
                        )
                      : const SizedBox.shrink()),
              const SizedBox(height: 20),
              Obx(
                () {
                  if (absensiC.showAlert.isTrue) {
                    return Column(
                      children: [
                        MaterialBanner(
                          elevation: 0,
                          forceActionsBelow: true,
                          backgroundColor: dangerColor,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Anda harus memilih waktu absensi terlebih dulu, sebelum anda melakukan absen!',
                              style: textWhite,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => absensiC.showAlert(false),
                              child: Text(
                                'Ya, saya mengerti.',
                                style: textWhite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Center(
                child: Obx(
                  () => gpsC.isWithinRange.isFalse
                      ? Text(
                          "Jarak anda dengan lokasi absen adalah ${gpsC.currentDistance.round()} m")
                      : homeController
                                  .setting.value.attendanceImageGeolocation ==
                              true
                          ? _buildActionButtons(gpsC, absensiC)
                          : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildViewAbsenceButton(),
                  Obx(() => homeController.setting.value.attendanceQrcode ==
                              true &&
                          gpsC.isWithinRange.isTrue
                      ? TextButton(
                          onPressed: () => Get.offAllNamed('/beranda/absen/qr'),
                          child: const Text(
                            "Scan absensi Kode QR",
                            style: TextStyle(fontSize: 13, color: primaryColor),
                          ),
                        )
                      : const SizedBox.shrink())
                ],
              ),
              Obx(() => gpsC.isWithinRange.isFalse
                  ? _infoGPS(context)
                  : const SizedBox.shrink())
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoGPS(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: infoColor.withOpacity(0.1), // Warna latar lebih lembut
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: infoColor), // Warna lebih kontras
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anda berada di luar jangkauan radius yang diizinkan.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  'Pastikan lokasi Anda sesuai dan coba lagi.',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  'Pastikan GPS di ponsel Anda sudah dikalibrasi untuk akurasi yang lebih baik. Tap ikon info 🔍 untuk detail kalibrasi.',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () => _showGpsInfo(),
            child: const Icon(Icons.info_outline, color: infoColor, size: 24),
          ),
        ],
      ),
    );
  }

  void _showGpsInfo() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.gps_fixed, color: Colors.blue, size: 32),
            const SizedBox(height: 10),
            const Text(
              '🔧 Cara Kalibrasi GPS:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _gpsStep(
                'Aktifkan GPS dengan akurasi tinggi di pengaturan lokasi.'),
            _gpsStep(
                'Buka Google Maps, lalu buat gerakan angka 8 dengan ponsel.'),
            _gpsStep('Pastikan koneksi stabil (WiFi/Internet & GPS menyala).'),
            _gpsStep('Coba lagi setelah beberapa detik.'),
            const SizedBox(height: 10),
            const Text(
              'Jika masalah berlanjut, restart perangkat dan ulangi proses.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Ya, saya mengerti',
                      style: textPrimary,
                    )),
                TextButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(
                        'https://support.google.com/maps/answer/2839911?hl=id&co=GENIE.Platform%3DAndroid');
                    try {
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Tidak dapat membuka tautan';
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print("=================tautan $e");
                      }
                      Get.snackbar('Error', e.toString(),
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: Text(
                    'Informasi lebih lanjut',
                    style: textInfo,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _gpsStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildTextRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Absen Masuk',
          style: textRowBoldSm,
        ),
        Text(
          'Absen Keluar',
          style: textRowBoldSm,
        ),
      ],
    );
  }

  Widget _buildTimeText(String time, bool status) {
    return Text(
      time,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: status ? Colors.black : dangerColor),
    );
  }

  Widget _buildViewAbsenceButton() {
    return TextButton(
      onPressed: () => Get.offAllNamed('/beranda/absen'),
      child: const Text(
        "Riwayat Absensi",
        style: TextStyle(fontSize: 13, color: primaryColor),
      ),
    );
  }

  Widget _buildActionButtons(GpsController gpsC, AbsensiController absensiC) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAbsenceButton(
            label: 'Absen Masuk',
            icon: Icons.login,
            isVisible: absensiC.btnIn.isFalse,
            onPressed: () {
              if (gpsC.isWithinRange.value && absensiC.timeId.value != null) {
                Get.offAllNamed('/beranda/absen/photo', arguments: {
                  'initial': 'in',
                  'timeId': absensiC.timeId.value
                });
              } else {
                absensiC.showAlert(true);
              }
            }),
        _buildAbsenceButton(
          label: 'Absen Pulang',
          icon: Icons.logout,
          isVisible: absensiC.btnOut.isFalse,
          onPressed: () {
            if (gpsC.isWithinRange.value && absensiC.timeId.value != null) {
              Get.offAllNamed('/beranda/absen/photo', arguments: {
                'initial': 'out',
                'timeId': absensiC.timeId.value
              });
            } else {
              absensiC.showAlert(true);
            }
          },
        ),
      ],
    );
  }

  Widget _buildAbsenceButton({
    required String label,
    required IconData icon,
    required bool isVisible,
    required VoidCallback? onPressed,
  }) {
    return isVisible
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, color: bgColor),
            label: Text(label, style: textWhite),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
