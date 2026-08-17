import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flux_mobile/core/network/token_refresh_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/app_constants.dart';
import '../storage/secure_storage_service.dart';
import 'auth_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient(SecureStorageService secureStorageService) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,

        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),

        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          Headers.acceptHeader: Headers.jsonContentType,
        },

        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(AuthInterceptor(secureStorageService , Get.find<TokenRefreshService>(),));

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
  }
}