import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../absensi/controllers/qr_code_controller.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodeController controller = Get.put(QrCodeController());

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          Get.offAllNamed('/beranda');
        },
        child: Scaffold(
          appBar: GlobatAppbar(
            title: 'Absensi Kode QR',
            act: () => Get.offAllNamed('/beranda'),
          ),
          body: Stack(
            children: [
              MobileScanner(
                controller: controller.scannerController,
                onDetect: controller.handleBarcode,
              ),

              /// Overlay Frame (Kotak Scanner)
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              /// Hasil Scan
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black54,
                  child: Obx(() {
                    if (controller.errorMessage.isNotEmpty) {
                      return Text(
                        "⚠️ ${controller.errorMessage.value}",
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      );
                    }
                    if (controller.qrData.isEmpty) {
                      return const Text(
                        "Pindain kode QR pada perangkat dan lokasi yang telah ditentukan perusahaan untuk melakukan absen!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    }
                    return Text(
                      "📌 Data: ${jsonEncode(controller.qrData['token'])}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
