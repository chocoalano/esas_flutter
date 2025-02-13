import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../../../../components/btn_action.dart';
import '../../../../../../../../constant.dart';
import '../../../../info_keluarga/views/form_card.dart';
import '../controllers/pendidikan_formal_controller.dart';

class PendidikanFormalView extends GetView<AkunPendidikanFormalController> {
  const PendidikanFormalView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Get.offAllNamed('/akun/pendidikan-pengalaman');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: const Text(
            'Form pendidikan formal',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () => Get.offAllNamed('/akun/pendidikan-pengalaman'),
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
                    index: index, onRemove: () => controller.removeForm(index));
              }
            },
          );
        }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BtnAction(
              act: () => controller.saveFormalEducation(),
              color: primaryColor,
              icon: Icons.save,
              isLoading: controller.isLoading,
              title: controller.isLoading.isFalse ? 'Simpan' : 'proses',
            )),
      ),
    );
  }
}
