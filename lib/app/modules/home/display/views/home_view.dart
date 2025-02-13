// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../components/BottomNavigation/bot_nav_view.dart';
import '../../../../../constant.dart';
import '../../../../../services/fcm_service.dart';
import '../../../../../support/support.dart';
import '../../../../../support/typography.dart';
import '../controllers/home_controller.dart';
import 'components/absencard.dart';
import 'components/anouncement.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final FcmService fcmService = Get.find<FcmService>();

    return FutureBuilder(
      future: fcmService.requestPermission(),
      builder: (context, snapshot) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            if (context.mounted) {
              SystemNavigator.pop();
            }
          },
          child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: SvgPicture.asset(
                'assets/svg/logo_esas.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () => controller.logout(),
                  icon: const Icon(
                    Icons.logout_sharp,
                    color: bgColor,
                  ),
                ),
              ],
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Obx(() {
                                if (controller.isLoading.isTrue) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                } else {
                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundColor: bgColor,
                                    child: controller.userDetail.value.avatar !=
                                            null
                                        ? ClipOval(
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/loading.gif',
                                              image:
                                                  "$baseUrlApi/assets/${controller.userDetail.value.avatar}",
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons.error,
                                                  color: Colors.grey,
                                                );
                                              },
                                            ),
                                          )
                                        : const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                          ),
                                  );
                                }
                              }),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => Text(
                                          controller.userDetail.value.name ??
                                              '',
                                          style: profileListTitle,
                                        )),
                                    Obx(() => Text(
                                          limitString(
                                              controller
                                                      .userDetail.value.email ??
                                                  '',
                                              23),
                                          style: profileListSubtitle,
                                        )),
                                    Obx(() => Text(
                                          limitString(
                                              controller.userDetail.value.nip ??
                                                  '',
                                              23),
                                          style: profileListSubtitle,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Absencard(),
                          const SizedBox(height: 20),
                          const Anouncement(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: BotNavView(),
          ),
        );
      },
    );
  }
}
