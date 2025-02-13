import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../auth_middleware.dart';
import '../modules/inbox/bindings/inbox_binding.dart';
import '../modules/inbox/views/inbox_view.dart';
import '../modules/karyawan/bindings/karyawan_binding.dart';
import '../modules/karyawan/views/karyawan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'modules/akun/akun.dart';
import 'modules/akun/info_payroll.dart';
import 'modules/akun/info_pendidikan_pengalaman.dart';
import 'modules/beranda/beranda.dart';
import 'modules/pengajuan/pengajuan.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // Lazy initialization for GetStorage
  static final GetStorage _storage = GetStorage();

  // Getter for token
  static String? get token => _storage.read<String>('token');

  // Define the initial route dynamically
  static const String initial = Routes.splash;

  // Define reusable middleware list
  static final List<GetMiddleware> _authMiddlewares = [AuthMiddleware()];

  static final routes = [
    // Splash route
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.native,
    ),

    // Login route
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.native,
    ),

    // Karyawan route
    GetPage(
      name: _Paths.karyawan,
      page: () => const KaryawanView(),
      binding: KaryawanBinding(),
      transition: Transition.noTransition,
      middlewares: _authMiddlewares,
    ),

    // Inbox route
    GetPage(
      name: _Paths.inbox,
      page: () => const InboxView(),
      binding: InboxBinding(),
      transition: Transition.noTransition,
      middlewares: _authMiddlewares,
    ),

    // Group route: Beranda
    ...BerandaRoutes.routes,

    // Group route: Akun
    ...AkunRoutes.routes,
    ...InfoPendidikanPengalamanRoutes.routes,
    ...InfoPayrollRoutes.routes,

    // Group route: Pengajuan
    ...PengajuanRoutes.routes,
  ];
}
