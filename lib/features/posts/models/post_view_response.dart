class PostViewResponse {

  final String id;
  final String content;
  final String status;
  final String? scheduledAtUtc;
  final List<String>? mediaUrls;


  PostViewResponse({
    required this.id,
    required this.content,
    required this.status,
    this.scheduledAtUtc,
    this.mediaUrls,
  });



  factory PostViewResponse.fromJson(
      Map<String, dynamic> json,
      ) {

    return PostViewResponse(

      id: json['id'] as String,

      content:
      json['content'] as String? ?? "",


      status:
      json['status'] as String? ?? "",


      scheduledAtUtc:
      json['scheduledAtUtc'] as String?,


      mediaUrls:
      json['mediaUrls'] == null
          ? null
          : List<String>.from(
        json['mediaUrls'],
      ),

    );
  }
}