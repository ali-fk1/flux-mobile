import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flux_mobile/core/constants/app_constants.dart';
import 'package:flux_mobile/core/network/token_refresh_service.dart';
import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final Dio _dio;
  final TokenRefreshService _tokenRefreshService;

  static final _tokenEndpoint =AppConstants.tokenUrl;
  static const _clientId = 'flux-mobile';

  bool _isRefreshing = false;
  final List<void Function()> _pendingRequests = [];

  AuthInterceptor(this._secureStorageService , this._tokenRefreshService) : _dio = Dio();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorageService.getAccessToken();
    debugPrint('AuthInterceptor: token = $token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final success = await _tokenRefreshService.tryRefresh();
    if (!success) {
      return handler.next(err);
    }

    final newToken = await _secureStorageService.getAccessToken();
    final opts = err.requestOptions;
    opts.headers['Authorization'] = 'Bearer $newToken';

    try {
      final retryResponse = await _dio.fetch(opts);
      return handler.resolve(retryResponse);
    } catch (e) {
      return handler.next(err);
    }
  }

}