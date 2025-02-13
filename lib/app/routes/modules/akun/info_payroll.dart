
import 'package:get/get.dart';

import '../../../../auth_middleware.dart';
import '../../../modules/akun/modules/info_payroll/form/bindings/form_payroll_binding.dart';
import '../../../modules/akun/modules/info_payroll/form/views/form_payroll_view.dart';
import '../../../modules/akun/modules/info_payroll/info/bindings/info_payroll_binding.dart';
import '../../../modules/akun/modules/info_payroll/info/views/info_payroll_view.dart';

class InfoPayrollRoutes {
  static const path = '/akun';
  static final routes = [
    GetPage(
        name: '$path/info-payroll',
        page: () => const InfoPayrollView(),
        binding: InfoPayrollBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/info-payroll/form',
        page: () => const FormPayrollView(),
        binding: FormPayrollBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
