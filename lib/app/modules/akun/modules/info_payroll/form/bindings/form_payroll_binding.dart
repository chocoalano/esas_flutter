import 'package:get/get.dart';

import '../../../../../../networks/api/akun/api_auth.dart';
import '../controllers/form_payroll_controller.dart';

class FormPayrollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormPayrollController>(
      () => FormPayrollController(),
    );
    Get.lazyPut<ApiAuth>(
      () => ApiAuth(),
    );
  }
}
