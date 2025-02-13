import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../constant.dart';
import '../controllers/info_tambahan_controller.dart';

class InfoTambahanView extends GetView<InfoTambahanController> {
  const InfoTambahanView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/akun');
      },
      child: Scaffold(
        appBar: GlobatAppbar(
          title: 'Info Tambahan',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialBanner(
                  elevation: 0,
                  padding: const EdgeInsets.all(20),
                  content: const Text(
                    'Belum ada informasi tambahan untuk saat ini.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  leading: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 50,
                  ),
                  backgroundColor: infoColor,
                  actions: [
                    IconButton(
                      onPressed: () {
                        // Action ketika tombol ditekan
                      },
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
