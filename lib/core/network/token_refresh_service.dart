import 'package:dio/dio.dart';
import 'package:flux_mobile/core/constants/app_constants.dart';
import '../storage/secure_storage_service.dart';

class TokenRefreshService {
  final Dio _dio = Dio();
  final SecureStorageService _secureStorageService;

  static final _tokenEndpoint = AppConstants.tokenUrl;
  static const _clientId = 'flux-mobile';

  Future<bool>? _ongoingRefresh;

  TokenRefreshService(this._secureStorageService);

  Future<bool> tryRefresh() {
    // If a refresh is already in progress, piggyback on it instead of starting a new one
    return _ongoingRefresh ??= _doRefresh().whenComplete(() {
      _ongoingRefresh = null;
    });
  }

  Future<bool> _doRefresh() async {
    final refreshToken = await _secureStorageService.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final newTokens = await _refreshAccessToken(refreshToken);
      await _secureStorageService.saveAccessToken(newTokens['access_token']);
      await _secureStorageService.saveRefreshToken(newTokens['refresh_token']);
      return true;
    } catch (e) {
      await _secureStorageService.clear();
      return false;
    }
  }

  Future<Map<String, dynamic>> _refreshAccessToken(String refreshToken) async {
    final response = await _dio.post(
      _tokenEndpoint,
      data: {
        'grant_type': 'refresh_token',
        'client_id': _clientId,
        'refresh_token': refreshToken,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return response.data as Map<String, dynamic>;
  }
}