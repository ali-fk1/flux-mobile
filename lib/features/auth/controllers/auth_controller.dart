import 'package:flutter/cupertino.dart';
import 'package:flux_mobile/core/storage/secure_storage_service.dart';
import 'package:flux_mobile/features/auth/services/keycloak_auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final KeycloakAuthService _keycloakAuthService;
  final SecureStorageService _secureStorageService;

  AuthController(this._keycloakAuthService, this._secureStorageService);

  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  // final isPasswordVisible = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;

      final result = await _keycloakAuthService.login();

      if (result?.accessToken != null) {
        await _secureStorageService.saveAccessToken(result!.accessToken!);

        if (result.refreshToken != null) {
          await _secureStorageService.saveRefreshToken(result.refreshToken!);
        }

        Get.offAllNamed('/posts');
      }
    } catch (e, stackTrace) {
      debugPrint("LOGIN ERROR: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final result = await _keycloakAuthService.register();

    if (result?.accessToken == null) {
      return;
    }

    if (result!.accessToken != null) {
      await _secureStorageService.saveAccessToken(result.accessToken!);
    }

    if (result.refreshToken != null) {
      await _secureStorageService.saveRefreshToken(result.refreshToken!);
    }

    Get.offAllNamed('/connectX');
  }

  // void togglePasswordVisibility(){
  //   isPasswordVisible.value = !isPasswordVisible.value;
  // }
}
