import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flux_mobile/app/routes/app_routes.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  void init() {
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) _handleUri(uri);
    });

    _subscription = _appLinks.uriLinkStream.listen(
      _handleUri,
      onError: (err) => debugPrint('DeepLinkService: error: $err'),
    );
  }

  void _handleUri(Uri uri) {
    debugPrint('DeepLinkService: received $uri');

    if (uri.scheme == 'flux' && uri.host == 'x-connect') {
      if (uri.path == '/success') {
        debugPrint('X connected successfully');
        Get.offAllNamed(AppRoutes.posts);
      } else if (uri.path == '/error') {
        final message = uri.queryParameters['message'];
        debugPrint('X connect error: $message');
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
