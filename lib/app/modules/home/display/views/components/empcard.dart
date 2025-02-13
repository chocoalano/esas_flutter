import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant.dart';
import '../../../../../../support/support.dart';
import '../../../../../../support/typography.dart';
import '../../controllers/home_controller.dart';

class Empcard extends StatelessWidget {
  const Empcard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.setAccount();
    final imageUrl = controller.userDetail.value.avatar;
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Obx(
            () => (controller.userDetail.value.avatar != null)
                ? CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.network(
                        "$baseUrlApi/assets/$imageUrl",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.grey);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        const SizedBox(width: 20), // Smaller spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    controller.userDetail.value.name ?? '',
                    style: profileListTitle,
                  )),
              Obx(() => Text(
                    limitString(controller.userDetail.value.email ?? '', 23),
                    style: profileListSubtitle,
                  )),
              Obx(() => Text(
                    limitString(controller.userDetail.value.nip ?? '', 23),
                    style: profileListSubtitle,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
