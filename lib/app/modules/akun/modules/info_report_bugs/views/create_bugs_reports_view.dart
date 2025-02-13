import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../../../components/btn_action.dart';
import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../constant.dart';
import '../../../../../../support/style.dart';
import '../controllers/bug_reports_form_controller.dart';

class CreateBugsReportView extends GetView<BugReportsFormController> {
  const CreateBugsReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/akun/info-report-bugs');
      },
      child: Scaffold(
        appBar: GlobatAppbar(
          title: 'Ajukan Laporan Bugs',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FormBuilder(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  // Title Input
                  FormBuilderTextField(
                    name: 'title',
                    decoration:
                        formInput(label: 'Judul laporan', icon: Icons.title),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(100),
                    ]),
                  ),
                  const SizedBox(height: 16),

                  // Platform Dropdown
                  FormBuilderDropdown<String>(
                    name: 'platform',
                    decoration: formInput(
                        label: 'Pilih platform', icon: Icons.device_hub),
                    items: ['web', 'android', 'ios']
                        .map((platform) => DropdownMenuItem(
                              value: platform,
                              child: Text(platform.capitalizeFirst!),
                            ))
                        .toList(),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: 16),

                  // Message Input
                  FormBuilderTextField(
                    name: 'message',
                    maxLines: 5,
                    decoration: formTextAreaInput(label: 'Pesan laporan'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10),
                    ]),
                  ),
                  const SizedBox(height: 16),

                  // Image Upload
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Obx(
                      () => Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: controller.pickedImage.value == null
                            ? const Center(
                                child: Text(
                                  'Tap to pick an image',
                                  style: TextStyle(color: primaryColor),
                                ),
                              )
                            : Image.file(
                                File(controller.pickedImage.value!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: BtnAction(
              act: controller.submitForm,
              color: primaryColor,
              icon: Icons.save_as_outlined,
              isLoading: controller.isLoading,
              title: 'Simpan data',
            ),
          ),
        ),
      ),
    );
  }
}
