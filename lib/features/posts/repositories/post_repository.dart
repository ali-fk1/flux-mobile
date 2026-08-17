import 'package:dio/dio.dart';
import '../models/cursor_page_respone.dart';
import '../models/post_status.dart';
import '../models/post_view_response.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(this._dio);

  Future<CursorPageResponse<PostViewResponse>> getPosts({
    String? cursor,
    int limit = 20,
    PostStatus? status,
  }) async {
    final response = await _dio.get(
      '/api/posts',
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        if (status != null) 'status': status.name,
        'size': limit,
      },
    );

    return CursorPageResponse.fromJson(
      response.data as Map<String, dynamic>,
          (json) => PostViewResponse.fromJson(json),
    );
  }

  Future<void> deleteScheduledPost({
    required String postId,
  }) async {



    final response = await _dio.delete(
        '/api/posts/$postId'
    );

    // if(response.statusCode != 200 || response.statusCode != 201 || response.statusCode != 204){
    //   throw Exception("Server returned code ${response.statusCode}");
    // }



  }

}