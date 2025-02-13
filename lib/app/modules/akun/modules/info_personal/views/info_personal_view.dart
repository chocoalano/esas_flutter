import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../constant.dart';
import '../../../../../../support/support.dart';
import '../../../../../../support/typography.dart';
import '../controllers/info_personal_controller.dart';

class InfoPersonalView extends GetView<InfoPersonalController> {
  const InfoPersonalView({super.key});

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
        backgroundColor: bgColor,
        appBar: GlobatAppbar(
          title: 'Info Personal',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Obx(() {
                  if (controller.isloading.isFalse) {
                    return Column(
                      children: [
                        _buildInfoSection(controller),
                        const SizedBox(height: 10),
                        _buildAddressSection(
                          'Alamat lengkap',
                          controller.profile.value.citizenAddress ?? 'Unknown',
                        ),
                        const SizedBox(height: 10),
                        _buildAddressSection(
                          'Alamat tempat tinggal lengkap',
                          controller.profile.value.residentialAddress ??
                              'Unknown',
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                }),
              ),
              const SizedBox(height: 30),
              Obx(() => _buildBanner(controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(InfoPersonalController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Pribadi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          _buildInfoRow('Nama',
              limitString(controller.profile.value.name ?? 'Unknown', 20)),
          _buildInfoRow('NIP', controller.profile.value.nip ?? 'Unknown'),
          _buildInfoRow('Email',
              limitString(controller.profile.value.email ?? 'Unknown', 20)),
          _buildInfoRow('Tlp/HP', controller.profile.value.phone ?? 'Unknown'),
          _buildInfoRow(
              'Tempat lahir',
              limitString(
                  controller.profile.value.placebirth ?? 'Unknown', 30)),
          _buildInfoRow(
              'Tanggal lahir', formatDate(controller.profile.value.datebirth)),
          _buildInfoRow('Jenis Kelamin',
              jenisKelamin(controller.profile.value.gender ?? 'm')),
          _buildInfoRow(
              'Gol. Darah', controller.profile.value.blood ?? 'Unknown'),
          _buildInfoRow(
              'Status pernikahan',
              statusPernikahan(
                  controller.profile.value.maritalStatus ?? 'single')),
          _buildInfoRow(
              'Agama', controller.profile.value.religion ?? 'Unknown'),
          _buildInfoRow('Tipe Identitas',
              controller.profile.value.identityType ?? 'Unknown'),
          _buildInfoRow('No. Identitas',
              controller.profile.value.identityNumbers ?? 'Unknown'),
          _buildInfoRow(
              'Provinsi', controller.profile.value.province ?? 'Unknown'),
          _buildInfoRow('Kota', controller.profile.value.city ?? 'Unknown'),
          _buildInfoRow(
              'Alamat', controller.profile.value.citizenAddress ?? 'Unknown'),
        ],
      ),
    );
  }

  Widget _buildAddressSection(String title, String address) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            address,
            style: const TextStyle(color: Colors.black54),
            softWrap: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              label,
              style: _labelStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(InfoPersonalController controller) {
    if (controller.isBanner.isFalse) {
      return const SizedBox.shrink();
    }
    return MaterialBanner(
      elevation: 0,
      forceActionsBelow: true,
      backgroundColor: primaryColor,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Jika terdapat ketidak sesuaian data, anda dapat menghubungi Dept. HR untuk merevisinya hingga sesuai dengan data diri anda. Sesuaikan data anda untuk penggunaan yang lebih nyaman.',
          style: textWhite,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => controller.isBanner(false),
          child: Text(
            'Ya, saya mengerti.',
            style: textWhite,
          ),
        ),
      ],
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.grey[600],
    );
  }
}
