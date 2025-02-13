import 'package:get/get.dart';

import '../../../networks/api/api_inbox.dart';
import '../controllers/inbox_controller.dart';

class InboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiInbox>(
      () => ApiInbox(),
    );
    Get.lazyPut<InboxController>(
      () => InboxController(),
    );
  }
}
