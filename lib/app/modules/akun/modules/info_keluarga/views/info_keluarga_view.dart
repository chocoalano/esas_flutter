import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../../components/btn_action.dart';
import '../../../../../../constant.dart';
import '../controllers/info_keluarga_controller.dart';
import 'form_card.dart';

class InfoKeluargaView extends GetView<InfoKeluargaController> {
  const InfoKeluargaView({super.key});
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: const Text(
            'Info keluarga',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () => Get.offAllNamed('/akun'),
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: controller.addForm,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.formData.length,
            itemBuilder: (context, index) {
              if (controller.isLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else {
                return FormCard(
                  index: index,
                  onRemove: () => controller.removeForm(index),
                );
              }
            },
          );
        }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BtnAction(
              act: () => controller.saveForm(),
              color: primaryColor,
              icon: Icons.save,
              isLoading: controller.isLoading,
              title:
                  controller.isLoading.isFalse ? 'Ajukan permintaan' : 'proses',
            )),
      ),
    );
  }
}
