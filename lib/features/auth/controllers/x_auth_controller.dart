import 'package:flutter/cupertino.dart';
import 'package:flux_mobile/features/auth/repositories/x_auth_repository.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../posts/models/x_account_info_response.dart';

class XAuthController extends GetxController {
  final XAuthRepository _authRepository;

  XAuthController(this._authRepository);

  final Rx<XAccountInfoResponse?> accountInfo = Rx(null);
  final RxBool isLoadingAccount = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAccountInfo();
  }

  Future<void> loadAccountInfo() async {
    isLoadingAccount.value = true;
    try {
      accountInfo.value = await _authRepository.getAccountInfo();
    } finally {
      isLoadingAccount.value = false;
    }
  }

  Future<void> connectToX() async {
    final authUrl = await _authRepository.connectToX();
    final uri = Uri.parse(authUrl);

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched) {
      debugPrint('Could not launch X auth URL: $authUrl');
      // surface an error to the user here
    }
  }
}
