import 'package:flux_mobile/features/auth/views/welcome_page.dart';
import 'package:flux_mobile/features/auth/views/x_authentication_page.dart';
import 'package:flux_mobile/features/posts/views/posts_page.dart';
import 'package:flux_mobile/features/schedule/bindings/scheduling_binding.dart';
import 'package:flux_mobile/features/schedule/views/scheduling_page.dart';
import 'package:get/get.dart';

import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/bindings/splash_binding.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/splash_page.dart';
import '../../features/posts/bindings/posts_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () =>  LoginView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.posts,
      page: () =>  PostsPage(),
      binding: PostsBinding(),
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () =>  SchedulingPage(),
      binding: SchedulingBinding(),
    ),

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.connectX,
      page: () =>  XAuthenticationPage(),
      binding: AuthBinding(),
    ),



    GetPage(name: AppRoutes.welcome, page: ()=> WelcomePage()),
  ];

}