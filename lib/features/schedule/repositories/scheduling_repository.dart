import 'package:dio/dio.dart';

class SchedulingRepository {
  final Dio _dio;

  SchedulingRepository(this._dio);

  Future<void> createScheduledPost({
    required String platform,
    required String text,
    required DateTime localDateTime,
  }) async {
    final utcDateTime = localDateTime.toUtc();

    final scheduledAtUtc = utcDateTime.toIso8601String();

    final String userTimeZone = DateTime.now().timeZoneName;

    final Map<String, dynamic> payload = {
      "platform": platform,
      "text": text,
      "scheduled_at_utc": scheduledAtUtc,
      "user_time_zone": userTimeZone,
    };

    final response = await _dio.post('/api/schedule', data: payload);

    // if(response.statusCode != 200 || response.statusCode != 201 || response.statusCode != 204){
    //   throw Exception("Server returned code ${response.statusCode}");
    // }
  }

  Future<void> updateScheduledPost({
    required String postId,
    required String text,
    required DateTime localDateTime,
  }) async {
    final utcDateTime = localDateTime.toUtc();

    final scheduledAtUtc = utcDateTime.toIso8601String();

    final Map<String, dynamic> payload = {
      "text": text,
      "scheduled_at_utc": scheduledAtUtc,
    };

    final response = await _dio.patch('/api/posts/$postId', data: payload);

    // if(response.statusCode != 200 || response.statusCode != 201 || response.statusCode != 204){
    //   throw Exception("Server returned code ${response.statusCode}");
    // }
  }

  Future<void> postNow({required String text}) async {
    final Map<String, dynamic> payload = {"text": text};

    final response = await _dio.post('/api/post', data: payload);

    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 204) {
      throw Exception("Server returned code ${response.statusCode}");
    }
  }
}
