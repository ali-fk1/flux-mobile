import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../core/network/deep_link_service.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../core/network/token_refresh_service.dart';

class InitialBinding extends Bindings {

  @override
  void dependencies() {
    Get.put<SecureStorageService>(
      SecureStorageService(),
      permanent: true,
    );

    Get.put<TokenRefreshService>(
      TokenRefreshService(Get.find<SecureStorageService>()),
      permanent: true,
    );

    Get.put<DioClient>(
      DioClient(Get.find<SecureStorageService>()),
      permanent: true,
    );

    Get.put<DeepLinkService>(
      DeepLinkService()..init(),
      permanent: true,
    );
  }

}