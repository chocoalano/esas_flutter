import 'package:get/get.dart';

import '../../../../../networks/api/akun/api_auth.dart';
import '../controllers/bug_reports_form_controller.dart';
import '../controllers/bugs_report_controller.dart';

class BugsReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BugsReportController>(
      () => BugsReportController(),
    );
    Get.lazyPut<BugReportsFormController>(
      () => BugReportsFormController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
