import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {

  static  String get baseUrl =>
      dotenv.env['BASE_URL'] ?? '';

  static String get redirectUrl =>
      dotenv.env['REDIRECT_URL'] ?? '';

  static String get issuer =>
      dotenv.env['ISSUER'] ?? '';

  static String get clientId =>
      dotenv.env['CLIENT_ID'] ?? '';

  static String get tokenUrl =>
      dotenv.env['TOKEN_URL'] ?? '';

}