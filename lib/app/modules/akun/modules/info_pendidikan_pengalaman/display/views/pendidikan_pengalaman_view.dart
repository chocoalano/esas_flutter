import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../../constant.dart';
import '../controllers/akun_pendidikan_pengalaman_controller.dart';
import 'widget/education_option_builder.dart';

class PendidikanPengalamanView
    extends GetView<AkunPendidikanPengalamanController> {
  const PendidikanPengalamanView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getProfile();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: GlobatAppbar(
        title: 'Info pendidikan & pengalaman',
        act: () => Get.offAllNamed('/akun'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
            Get.offAllNamed('/akun');
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EducationOptionBuilder.buildSection(
                  title: 'Info pendidikan formal',
                  onTitleTap: () => controller.movePage('/pendidikan-formal'),
                  options: EducationOptionBuilder.buildFormalEducationOptions(
                    controller.formalEducation,
                    'Belum ada data pendidikan formal',
                  ),
                ),
                EducationOptionBuilder.buildSection(
                  title: 'Info pendidikan informal',
                  onTitleTap: () => controller.movePage('/pendidikan-informal'),
                  options: EducationOptionBuilder.buildInformalEducationOptions(
                    controller.informalEducation,
                    'Belum ada data pendidikan informal',
                  ),
                ),
                EducationOptionBuilder.buildSection(
                  title: 'Info pengalaman kerja',
                  onTitleTap: () => controller.movePage('/pengalaman-kerja'),
                  options: EducationOptionBuilder.buildWorkExperienceOptions(
                    controller.workExperience,
                    'Belum ada data pengalaman kerja',
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
