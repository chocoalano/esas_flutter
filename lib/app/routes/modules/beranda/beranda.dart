
import 'package:get/get.dart';

import '../../../../auth_middleware.dart';
import '../../../modules/absensi/bindings/absensi_binding.dart';
import '../../../modules/absensi/views/absensi_view.dart';
import '../../../modules/home/display/bindings/home_binding.dart';
import '../../../modules/home/display/views/components/photo_screen.dart';
import '../../../modules/home/display/views/components/qr_screen.dart';
import '../../../modules/home/display/views/home_view.dart';
import '../../../modules/home/modules/anouncement_detail/bindings/anouncement_detail_binding.dart';
import '../../../modules/home/modules/anouncement_detail/views/anouncement_detail_screen.dart';

class BerandaRoutes {
  static const path = '/beranda';
  static final routes = [
    GetPage(
        name: path,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/anouncement',
        page: () => const AnouncementDetailScreen(),
        binding: AnouncementDetailBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/absen',
        page: () => const AbsensiView(),
        binding: AbsensiBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/absen/photo',
        page: () => const PhotoScreen(),
        binding: AbsensiBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '$path/absen/qr',
        page: () => const QrCodeScreen(),
        binding: AbsensiBinding(),
        transition: Transition.noTransition,
        middlewares: [AuthMiddleware()])
  ];
}
