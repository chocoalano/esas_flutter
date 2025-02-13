import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/build_empty_message.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../../support/typography.dart';
import '../../../models/Permit/permit_type.dart';
import '../controllers/pengajuan_list_controller.dart';
import 'list_item.dart';

class PengajuanListView extends StatelessWidget {
  const PengajuanListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final PengajuanListController controller =
        Get.find<PengajuanListController>();
    final data = Get.arguments as PermitType;
    controller.loadMoreList(data.id);

    // Refresh function
    Future<void> onRefresh() async {
      await controller.refreshData(data.id);
    }

    // Scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.loadMoreList(data.id);
      }
    });
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/pengajuan');
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text(
            capitalizedString(data.type),
            style: appbarTitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.offAllNamed('/pengajuan'),
              icon: const Icon(
                Icons.arrow_back,
                color: bgColor,
              )),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: bgColor),
              onPressed: () => controller.refreshData(data.id),
            ),
            IconButton(
              icon: const Icon(Icons.pending_actions_outlined, color: bgColor),
              onPressed: () => controller.shortOnNeedApproved(data.id),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: Obx(() {
            if (controller.list.isEmpty) {
              return Center(
                child: buildEmptyMessage(
                    'Tidak ada data', 'Data akan ditampilkan disini'),
              );
            }
            return ListView.builder(
              controller: scrollController,
              itemCount: controller.list.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.list.length) {
                  final data = controller.list[index];
                  return listItem(data);
                } else if (controller.hasMore.value) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: buildEmptyMessage('Tidak ada data lagi',
                          'Data lanjutan akan ditampilkan disini'),
                    ),
                  );
                } else {
                  return const SizedBox(); // Tidak ada lebih banyak data
                }
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          tooltip: 'Ajukan permohonan ${data.type}',
          onPressed: () =>
              Get.offAllNamed('/pengajuan/cuti/create', arguments: data),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
