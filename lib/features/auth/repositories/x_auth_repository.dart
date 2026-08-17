import 'package:dio/src/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flux_mobile/features/posts/models/x_account_info_response.dart';

class XAuthRepository {

  final Dio _dio;

  XAuthRepository(this._dio);

  Future<String> connectToX() async {
    final response = await _dio.post('/api/x/connect');
    final data = response.data as Map<String, dynamic>;
    final authUrl = data['authUrl'] as String;
    debugPrint('the auth url is: $authUrl');
    return authUrl;
  }

  Future<bool> checkStatus() async{

    final response = await _dio.get('/api/x/status');
    final data = response.data as Map<String, dynamic>;
    return data['connected'] as bool? ?? false;

  }

  Future<XAccountInfoResponse> getAccountInfo() async {
    final response = await _dio.get('/api/x/account');
    return XAccountInfoResponse.fromJson(response.data as Map<String, dynamic>);
  }

}