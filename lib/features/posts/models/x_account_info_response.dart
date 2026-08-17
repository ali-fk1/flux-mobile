 class XAccountInfoResponse {
  final bool connected;
  final String? username;
  final String? profileImageUrl;

  XAccountInfoResponse({
    required this.connected,
     this.username,
     this.profileImageUrl
 });

  factory XAccountInfoResponse.fromJson(Map<String, dynamic> json) {
    return XAccountInfoResponse(
      connected: json['connected'] as bool? ?? false,
      username: json['username'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  factory XAccountInfoResponse.disconnected() {
    return XAccountInfoResponse(connected: false, username: null, profileImageUrl: null);
  }

}