import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../../components/BottomNavigation/bot_nav_view.dart';
import '../../../../components/widgets/build_empty_message.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../../support/typography.dart';
import '../controllers/pengajuan_controller.dart';

class PengajuanView extends GetView<PengajuanController> {
  const PengajuanView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          // Tampilkan dialog konfirmasi keluar (opsional)
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text(
            'Pengajuan',
            style: appbarTitle,
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.list.isEmpty) {
            return Center(
              child: buildEmptyMessage(
                  'Tidak ada data', 'Data tim akan ditampilkan disini'),
            );
          }
          final Map<String, IconData> typeIcons = {
            'cuti tahunan': Icons.holiday_village,
            'Dispensasi menikah': Icons.favorite,
            'Dispensasi menikahkan anak': Icons.favorite_border,
            'Dispensasi khitan/baptis anak': Icons.child_care,
            'Dispensasi istri melahirkan/keguguran': Icons.pregnant_woman,
            'Dispensasi Keluarga/Anggota Keluarga Dalam Satu Rumah Meninggal':
                Icons.hotel_sharp,
            'Dispensasi Melahirkan/Keguguran': Icons.local_hospital,
            'cuti haid': Icons.woman,
            'Dispensasi ibadah agama': Icons.mosque_outlined,
            'Dispensasi Wisuda (anak/pribadi)': Icons.school,
            'Dispensasi Lain-lain': Icons.perm_contact_cal,
            'Dispensasi Tugas Kantor (dalam/luar kota)':
                Icons.task_alt_outlined,
            'Izin Sakit (surat dokter & resep)': Icons.sick,
            'Izin Sakit (tanpa surat dokter)': Icons.sick_outlined,
            'Izin Sakit Kecelakaan Kerja (surat dokter & resep)':
                Icons.sticky_note_2_outlined,
            'Izin Sakit (rawat inap)': Icons.single_bed_outlined,
          };
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: controller.list.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.list.length) {
                  final data = controller.list[index];
                  return buildPengajuanOption(context,
                      icon: typeIcons[data.type] ?? Icons.help_outline,
                      text: data.type,
                      onTap: () =>
                          Get.offAllNamed('pengajuan/cuti', arguments: data));
                } else {
                  return const SizedBox(); // Tidak ada lebih banyak data
                }
              },
            ),
          );
        }),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  Widget buildPengajuanOption(BuildContext context,
      {required IconData icon, required String text, VoidCallback? onTap}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title:
            Text(capitalizedString(text), style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
