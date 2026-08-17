import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flux_mobile/core/constants/app_constants.dart';

class KeycloakAuthService {

  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  static  String clientId = AppConstants.clientId;

  static  String redirectUrl = AppConstants.redirectUrl;

  static  String issuer = AppConstants.issuer;

  Future<AuthorizationTokenResponse?> login() async {

    final result =
    await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        issuer: issuer,
        scopes: [
          "openid",
          "profile",
          "email",
          "offline_access",
        ],
      ),
    );


    return result;

  }
  Future<AuthorizationTokenResponse?> register() async {

    final result =
    await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        clientId,
        redirectUrl,
        serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: '$issuer/protocol/openid-connect/registrations',
            tokenEndpoint: '$issuer/protocol/openid-connect/token'
        ),
        scopes: [
          "openid",
          "profile",
          "email",
          "offline_access",
        ],
      ),
    );


    return result;

  }

}