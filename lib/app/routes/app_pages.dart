import 'package:get/get.dart';

import '../../presentation/forgot_password/bindings/forgot_password_binding.dart';
import '../../presentation/forgot_password/views/forgot_password_view.dart';
import '../../presentation/login/bindings/login_binding.dart';
import '../../presentation/login/views/login_view.dart';
import '../../presentation/police/requests/bindings/requests_binding.dart';
import '../../presentation/police/requests/views/requests_view.dart';
import '../../presentation/register/bindings/register_binding.dart';
import '../../presentation/register/views/register_view.dart';
import '../../presentation/splash/bindings/splash_binding.dart';
import '../../presentation/splash/views/splash_view.dart';
import '../../presentation/victom/landing/bindings/landing_binding.dart';
import '../../presentation/victom/landing/views/landing_view.dart';
import '../../presentation/web/web_dashboard/bindings/web_dashboard_binding.dart';
import '../../presentation/web/web_dashboard/views/web_dashboard_view.dart';
import '../../presentation/web/web_login/bindings/web_login_binding.dart';
import '../../presentation/web/web_login/views/web_login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.REQUESTS,
      page: () => const RequestsView(),
      binding: RequestsBinding(),
    ),
    GetPage(
      name: _Paths.WEB_DASHBOARD,
      page: () => const WebDashboardView(),
      binding: WebDashboardBinding(),
    ),
    GetPage(
      name: _Paths.WEB_LOGIN,
      page: () => const WebLoginView(),
      binding: WebLoginBinding(),
    ),
  ];
}
