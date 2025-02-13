import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/btn_action.dart';
import '../../../../components/widgets/globat_appbar.dart';
import '../../../../components/widgets/snackbar.dart';
import '../../../../constant.dart';
import '../../../../support/style.dart';
import '../../../../support/typography.dart';
import '../../../models/Permit/permit_type.dart';
import '../controllers/pengajuan_create_controller.dart';

class PengajuanCreateView extends GetView<PengajuanCreateController> {
  const PengajuanCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as PermitType;

    const textError = TextStyle(fontSize: 12, color: dangerColor);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          Get.offAllNamed('/pengajuan/cuti', arguments: data);
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Ajukan Permintaan',
          act: () => Get.offAllNamed('/pengajuan/cuti', arguments: data),
        ),
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          return SingleChildScrollView(
            child: FormBuilder(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () {
                      if (controller.showInfo.isTrue) {
                        return MaterialBanner(
                          elevation: 0,
                          forceActionsBelow: true,
                          backgroundColor: primaryColor,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Anda harus memiliki jadwal absen untuk dipilih sebagai parameter kapan anda akan mengajukan permohonan, jika anda belum memiliki jadwal absen pada waktu yang ingin anda pilih maka silahkan hubungi dept HR!, dan tanggal yang anda pilih untuk memulai cuti harus sama dengan jadwal yang sudah anda pilih.',
                              style: textWhite,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => controller.hideAlert(),
                              child: const Text(
                                'Ya, saya mengerti.',
                                style: TextStyle(color: bgColor),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Dropdown untuk memilih jadwal kerja
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Obx(() => FormBuilderDropdown<int>(
                            name: 'user_timework_schedule_id',
                            decoration: formInput(
                              label: 'Pilih Jadwal',
                              icon: Icons.calendar_today_outlined,
                            ),
                            items: controller.listJadwalKerja.map((schedule) {
                              return DropdownMenuItem<int>(
                                value: schedule.id,
                                child: Text(
                                    "${schedule.workDay!} - ${schedule.timeWork?.name}"),
                              );
                            }).toList(),
                            validator: FormBuilderValidators.required(
                                errorText: 'Jadwal kerja ID harus diisi'),
                            hint: const Text('Pilih salah satu jadwal kerja'),
                          ))),
                  Obx(() => controller.errorMessages['permit_numbers'] != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            controller.errorMessages['permit_numbers'] ?? '',
                            style: textError,
                          ),
                        )
                      : const SizedBox.shrink()),

                  // Tanggal mulai
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: FormBuilderDateTimePicker(
                      name: 'start_date',
                      decoration: formInput(
                        label: 'Tanggal Mulai',
                        icon: Icons.calendar_today,
                      ),
                      inputType: InputType.date,
                      format: DateFormat('yyyy-MM-dd'),
                      validator: FormBuilderValidators.required(
                          errorText: 'Tanggal mulai harus diisi'),
                    ),
                  ),
                  Obx(() => controller.errorMessages['start_date'] != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            controller.errorMessages['start_date'] ?? '',
                            style: textError,
                          ),
                        )
                      : const SizedBox.shrink()),
                  // Tanggal selesai
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: FormBuilderDateTimePicker(
                      name: 'end_date',
                      decoration: formInput(
                        label: 'Sampai Dengan',
                        icon: Icons.calendar_today,
                      ),
                      inputType: InputType.date,
                      format: DateFormat('yyyy-MM-dd'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Tanggal selesai harus diisi'),
                        (value) {
                          final startDate = controller.formKey.currentState
                              ?.fields['start_date']?.value;
                          if (value != null &&
                              startDate != null &&
                              value.isBefore(startDate)) {
                            return 'Tanggal selesai harus setelah tanggal mulai';
                          }
                          return null;
                        },
                      ]),
                    ),
                  ),
                  Obx(() => controller.errorMessages['end_date'] != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            controller.errorMessages['end_date'] ?? '',
                            style: textError,
                          ),
                        )
                      : const SizedBox.shrink()),

                  // Waktu mulai
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: FormBuilderDateTimePicker(
                      name: 'start_time',
                      decoration: formInput(
                        label: 'Dari Jam',
                        icon: Icons.access_time,
                      ),
                      inputType: InputType.time,
                      format: DateFormat('HH:mm:ss'),
                      validator: FormBuilderValidators.required(
                          errorText: 'Waktu mulai harus diisi'),
                    ),
                  ),
                  Obx(() => controller.errorMessages['start_time'] != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            controller.errorMessages['start_time'] ?? '',
                            style: textError,
                          ),
                        )
                      : const SizedBox.shrink()),

                  // Waktu selesai
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: FormBuilderDateTimePicker(
                      name: 'end_time',
                      decoration: formInput(
                        label: 'Sampai Jam',
                        icon: Icons.access_time,
                      ),
                      inputType: InputType.time,
                      format: DateFormat('HH:mm:ss'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Waktu selesai harus diisi'),
                        (value) {
                          final startTime = controller.formKey.currentState
                              ?.fields['start_time']?.value;
                          if (value != null &&
                              startTime != null &&
                              value.isBefore(startTime)) {
                            return 'Waktu selesai harus setelah waktu mulai';
                          }
                          return null;
                        },
                      ]),
                    ),
                  ),
                  Obx(() => controller.errorMessages['end_time'] != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            controller.errorMessages['end_time'] ?? '',
                            style: textError,
                          ),
                        )
                      : const SizedBox.shrink()),

                  // Catatan
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: FormBuilderTextField(
                      name: 'notes',
                      decoration: formTextAreaInput(label: 'Keterangan'),
                      maxLines: 3,
                      validator: FormBuilderValidators.required(
                          errorText: 'Keterangan harus diisi'),
                    ),
                  ),
                  Obx(() => controller.errorMessages['notes'] != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            controller.errorMessages['notes'] ?? '',
                            style: textError,
                          ),
                        )
                      : const SizedBox.shrink()),
                  // Input file (jika data.withFile bernilai true)
                  if (data.withFile)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FormBuilderField<File>(
                        name: 'file_upload',
                        validator: (file) {
                          if (file == null) {
                            return 'File harus diunggah';
                          } else if (file.lengthSync() == 0) {
                            return 'File tidak boleh kosong';
                          }
                          // Tambahkan validasi tambahan jika diperlukan, seperti jenis file
                          return null;
                        },
                        builder: (field) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Unggah file untuk referensi permohonan',
                              style: caption,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                await controller.selectFile();
                                final file = controller.selectedFile.value;

                                // Validasi tambahan pada saat memilih file
                                if (file != null) {
                                  if (file.lengthSync() == 0) {
                                    showErrorSnackbar(
                                        'File tidak boleh kosong');
                                    return;
                                  }
                                  field.didChange(file);
                                }
                              },
                              child: Obx(
                                () => Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: controller.selectedFile.value == null
                                      ? const Center(
                                          child: Text(
                                            'Tap untuk memilih file',
                                            style:
                                                TextStyle(color: primaryColor),
                                          ),
                                        )
                                      : Image.file(
                                          controller.selectedFile.value!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  field.errorText!,
                                  style: textDanger,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: BtnAction(
              act: () => controller.submitForm(data.id),
              color: primaryColor,
              icon: Icons.save_as_outlined,
              isLoading: controller.isLoading,
              title: 'Simpan Data',
            ),
          ),
        ),
      ),
    );
  }
}
