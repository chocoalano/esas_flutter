
import 'package:get/get.dart';

import '../../../../auth_middleware.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/display/bindings/pendidikan_pengalaman_binding.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/display/views/pendidikan_pengalaman_view.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_formal/bindings/pendidikan_formal_binding.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_formal/views/pendidikan_formal_view.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_informal/bindings/pendidikan_informal_binding.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/modules/pendidikan_informal/views/pendidikan_informal_view.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/modules/pengalaman_kerja/bindings/pengalaman_kerja_binding.dart';
import '../../../modules/akun/modules/info_pendidikan_pengalaman/modules/pengalaman_kerja/views/pengalaman_kerja_view.dart';

class InfoPendidikanPengalamanRoutes {
  static const path = '/akun/pendidikan-pengalaman';
  static final routes = [
    GetPage(
        name: path,
        page: () => const PendidikanPengalamanView(),
        binding: PendidikanPengalamanBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/pendidikan-formal',
        page: () => const PendidikanFormalView(),
        binding: PendidikanFormalBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/pendidikan-informal',
        page: () => const PendidikanInformalView(),
        binding: PendidikanInformalBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/pengalaman-kerja',
        page: () => const PengalamanKerjaView(),
        binding: PengalamanKerjaBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
  ];
}
