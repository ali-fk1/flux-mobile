import 'package:flutter/cupertino.dart';
import 'package:flux_mobile/features/auth/repositories/x_auth_repository.dart';
import 'package:get/get.dart';
import 'package:flux_mobile/app/routes/app_routes.dart';
import 'package:flux_mobile/core/network/token_refresh_service.dart';
import 'package:flux_mobile/core/storage/secure_storage_service.dart';

import '../../../core/network/token_refresh_service.dart';

class SplashController extends GetxController {
  final TokenRefreshService _tokenRefreshService;
  final SecureStorageService _secureStorageService;

  SplashController(this._tokenRefreshService, this._secureStorageService);

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    debugPrint('SplashController: checking auth...');
    try {
      final refreshToken = await _secureStorageService.getRefreshToken();
      debugPrint('SplashController: refreshToken = $refreshToken');

      if (refreshToken == null) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      final success = await _tokenRefreshService.tryRefresh();
      if (!success) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      debugPrint('SplashController: refresh success = $success');
      Get.offAllNamed(success ? AppRoutes.posts : AppRoutes.login);
    } catch (e, st) {
      debugPrint('SplashController: unexpected error: $e\n$st');
      Get.offAllNamed(AppRoutes.welcome);
    }
  }
}