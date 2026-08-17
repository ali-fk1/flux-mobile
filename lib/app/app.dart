import 'package:flutter/material.dart';
import 'package:flux_mobile/app/routes/app_pages.dart';
import 'package:flux_mobile/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'theme/flux_colors.dart';

class FLuxApp extends StatelessWidget {
  const FLuxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flux',
      debugShowCheckedModeBanner: false,
      theme: fluxLightTheme,
      darkTheme: fluxDarkTheme,
      themeMode: ThemeMode.dark,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,


    );
  }
}
