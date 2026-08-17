class CursorPageResponse<T> {
  final List<T> content;
  final String? nextCursor;
  final bool hasNext;

  CursorPageResponse({
    required this.content,
    required this.nextCursor,
    required this.hasNext,
  });

  factory CursorPageResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return CursorPageResponse(
      content: (json['content'] as List)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
      hasNext: json['hasNext'] as bool,
    );
  }
}