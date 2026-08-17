import 'package:flux_mobile/core/storage/secure_storage_service.dart';
import 'package:flux_mobile/features/auth/controllers/auth_controller.dart';
import 'package:flux_mobile/features/auth/controllers/x_auth_controller.dart';
import 'package:flux_mobile/features/auth/repositories/x_auth_repository.dart';
import 'package:get/get.dart';

import '../../../core/network/dio_client.dart';
import '../services/keycloak_auth_service.dart';

class AuthBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<KeycloakAuthService>(
          () => KeycloakAuthService(),
    );

    Get.lazyPut<XAuthRepository>(
          () => XAuthRepository(Get.find<DioClient>().dio),
    );

    Get.lazyPut<XAuthController>(
        ()=> XAuthController( XAuthRepository(Get.find<DioClient>().dio))
    );


    Get.lazyPut<AuthController>(
            ()=>AuthController(
                Get.find<KeycloakAuthService>(),
                Get.find<SecureStorageService>()
            ),
    );

  }

}