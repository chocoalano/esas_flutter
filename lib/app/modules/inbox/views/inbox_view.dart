import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../components/BottomNavigation/bot_nav_view.dart';
import '../../../../components/widgets/build_empty_message.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../models/notification/notification_model.dart';
import '../controllers/inbox_controller.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

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
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: () async =>
              await Get.find<InboxController>().refreshData(),
          child: Obx(() {
            final controller = Get.find<InboxController>();

            // Scroll listener for pagination
            scrollController.addListener(() {
              if (scrollController.position.pixels >=
                      scrollController.position.maxScrollExtent - 100 &&
                  controller.hasMore.isTrue &&
                  !controller.isLoading.isTrue) {
                controller.loadMoreList();
              }
            });

            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            } else if (controller.list.isEmpty) {
              return Center(
                child: buildEmptyMessage(
                    'Tidak ada data', 'Data akan ditampilkan di sini'),
              );
            } else {
              return ListView.builder(
                controller: scrollController,
                itemCount: controller.list.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.list.length) {
                    return _buildListItem(controller.list[index], controller);
                  } else if (controller.hasMore.isTrue) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox(); // Tidak ada lebih banyak data
                  }
                },
              );
            }
          }),
        ),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      title: const Text(
        'Inbox',
        style: TextStyle(color: bgColor),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => Get.find<InboxController>().refreshData(),
          icon: const Icon(Icons.refresh, color: bgColor),
        ),
        IconButton(
          onPressed: () => Get.find<InboxController>().clearData(),
          icon: const Icon(Icons.clear, color: bgColor),
        ),
      ],
    );
  }

  Widget _buildListItem(NotificationModel data, InboxController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: ListTile(
          leading: Icon(
            data.readAt == null
                ? Icons.notifications_active
                : Icons.notifications,
            color: data.readAt == null ? primaryColor : Colors.grey,
          ),
          title: Text(
            limitString(data.data?.title ?? '', 30),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            data.data?.body ?? '',
            style: const TextStyle(color: Colors.black54),
          ),
          onTap: () => controller.read(data.id!),
        ),
      ),
    );
  }
}
