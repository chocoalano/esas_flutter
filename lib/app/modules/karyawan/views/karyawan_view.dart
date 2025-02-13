import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../components/BottomNavigation/bot_nav_view.dart';
import '../../../../components/widgets/build_empty_message.dart';
import '../../../../components/widgets/subtitle_row_text.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../models/users/user_view.dart';
import '../controllers/karyawan_controller.dart';

class KaryawanView extends GetView<KaryawanController> {
  const KaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    // Refresh function
    Future<void> onRefresh() async {
      await controller.refreshData();
    }

    // Scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.loadMoreList();
      }
    });

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
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              controller: controller.search,
              decoration: InputDecoration(
                hintText: 'Cari...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(color: Colors.white60),
                fillColor: bgColor.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.search, color: bgColor),
              ),
              style: const TextStyle(color: bgColor),
              onChanged: (value) => controller.refreshData(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear, color: bgColor),
              onPressed: controller.clearSearch,
            ),
            IconButton(
              icon: const Icon(Icons.refresh, color: bgColor),
              onPressed: controller.refreshData,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: Obx(() {
            if (controller.listKaryawan.isEmpty) {
              return Center(
                child: buildEmptyMessage(
                    'Tidak ada data', 'Data tim akan ditampilkan disini'),
              );
            }
            return ListView.builder(
              controller: scrollController,
              itemCount: controller.listKaryawan.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.listKaryawan.length) {
                  final data = controller.listKaryawan[index];
                  return _buildListItem(data);
                } else if (controller.hasMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox(); // Tidak ada lebih banyak data
                }
              },
            );
          }),
        ),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  Widget _buildListItem(UserView data) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.shade200,
        child: ClipOval(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Image.network(
              "$baseUrlApi/assets/${data.avatar}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.grey),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
      title: Text(
        limitString(data.name ?? '', 30),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSubtitleRow('Departement', data.departement ?? ''),
          buildSubtitleRow('Position', data.position ?? ''),
        ],
      ),
      onTap: () => _showDetails(data),
    );
  }

  void _showDetails(UserView item) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 2.5,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detail Karyawan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_outlined),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoRow('NIP', item.nip ?? ''),
            _buildInfoRow('Nama', limitString(item.name ?? '', 30)),
            _buildInfoRow('Email', limitString(item.email ?? '', 30)),
            _buildInfoRow('Gender', item.gender == 'm' ? 'Pria' : 'Wanita'),
            _buildInfoRow('Company', limitString(item.company ?? '', 30)),
            _buildInfoRow(
                'Departement', limitString(item.departement ?? '', 30)),
            _buildInfoRow('Position', limitString(item.position ?? '', 30)),
            _buildInfoRow('Join date', formatDate(item.joinDate)),
            _buildInfoRow('Sign date', formatDate(item.signDate)),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
