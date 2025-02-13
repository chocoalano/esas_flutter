import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../components/widgets/build_empty_message.dart';
import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../constant.dart';
import '../controllers/bugs_report_controller.dart';
import 'list_item.dart';

class IndexBugsReportView extends GetView<BugsReportController> {
  const IndexBugsReportView({super.key});

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
          Get.offAllNamed('/akun');
        },
        child: Scaffold(
          appBar: GlobatAppbar(
            title: 'Laporan Bugs',
            act: () => Get.offAllNamed('/akun'),
          ),
          body: RefreshIndicator(
              onRefresh: onRefresh,
              child: Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
                } else if (controller.list.isEmpty) {
                  return Center(
                    child: buildEmptyMessage('Tidak ada data',
                        'Data bug anda akan ditampilkan disini'),
                  );
                } else {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.list.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.list.length) {
                        final data = controller.list[index];
                        return listItem(data);
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
                }
              })),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            tooltip: 'Ajukan laporan',
            onPressed: () => Get.offAllNamed('/akun/info-report-bugs/create'),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ));
  }
}
