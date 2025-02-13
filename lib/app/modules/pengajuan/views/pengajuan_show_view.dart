import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/widgets/globat_appbar.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../../support/typography.dart';
import '../../../models/Permit/permit_list.dart';
import '../controllers/pengajuan_show_controller.dart';
import 'btn_approval.dart';

class PengajuanShowView extends GetView<PengajuanShowController> {
  const PengajuanShowView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as PermitList;

    // Memuat detail data
    controller.loadDetail(data.id);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          Get.offAllNamed('/pengajuan/cuti', arguments: data.permitType);
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Detail Permintaan',
          act: () =>
              Get.offAllNamed('/pengajuan/cuti', arguments: data.permitType),
        ),
        body: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildDetailCard(data),
                  const SizedBox(height: 10),
                  _buildDescriptionCard(data),
                  const SizedBox(height: 10),
                  if (data.file != null && data.file!.isNotEmpty)
                    Container(
                      width: Get.width,
                      height: Get.height / 3.5,
                      decoration: BoxDecoration(
                        color: Colors
                            .grey.shade200, // Background color for image box
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (data.file != null && data.file!.isNotEmpty)
                            ? Image.network(
                                "$baseUrlApi/assets/${data.file}", // Full image URL
                                fit: BoxFit
                                    .contain, // Ensures the image fits properly within the box
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey
                                        .shade300, // Background color for the placeholder
                                    child: const Icon(
                                      Icons
                                          .image, // Icon to indicate missing image
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ); // Placeholder when image fails to load
                                },
                              )
                            : const SizedBox
                                .shrink(), // Placeholder when URL is empty
                      ),
                    ),
                  const SizedBox(height: 10),
                  validateApproval(data.approvals)
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: btnApproval(data),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Card untuk detail pengajuan
  Widget _buildDetailCard(PermitList data) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                limitString(data.permitType.type, 50),
                style: textRowBold,
              ),
            ),
            const SizedBox(height: 50),
            _buildDetailRow('Nama',
                limitString(controller.detail.value.user?.name ?? '---', 20)),
            _buildDetailRow('NIP', controller.detail.value.user?.nip ?? '---'),
            const Divider(),
            _buildDetailRow('Nomor pengajuan', data.permitNumbers),
            _buildDetailRow('Tanggal Dibuat', formatDate(data.createdAt)),
            _buildDetailRow('Tanggal Mulai', formatDate(data.startDate)),
            _buildDetailRow('Tanggal Selesai', formatDate(data.endDate)),
            _buildDetailRow('Waktu Mulai', data.startTime),
            _buildDetailRow('Waktu Selesai', data.endTime),
            const Divider(),
            if (data.approvals.isNotEmpty)
              ...data.approvals.map(
                (approval) => _buildDetailRow(
                  'Status ${approval.userType}',
                  approvalString(approval.userApprove!),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Card untuk keterangan pengajuan
  Widget _buildDescriptionCard(PermitList data) {
    return SizedBox(
      height: Get.height / 2.5, // Tinggi minimum
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Keterangan', style: textRowBoldSm),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    data.notes ?? 'Unknown notes',
                    style: textRowNormalSm,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper untuk membuat baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textRowBoldSm),
          Text(value, style: textRowNormalSm),
        ],
      ),
    );
  }
}
