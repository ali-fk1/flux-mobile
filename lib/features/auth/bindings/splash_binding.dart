import 'package:flux_mobile/features/auth/repositories/x_auth_repository.dart';
import 'package:get/get.dart';
import 'package:flux_mobile/core/network/token_refresh_service.dart';
import 'package:flux_mobile/core/storage/secure_storage_service.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(
        Get.find<TokenRefreshService>(),
        Get.find<SecureStorageService>(),
          ),
    );
  }
}