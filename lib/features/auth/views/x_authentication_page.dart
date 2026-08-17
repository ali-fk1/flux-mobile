import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/x_auth_controller.dart';
import '../widgets/social_platform_card.dart';

class XAuthenticationPage extends StatelessWidget {
  XAuthenticationPage({super.key});

  final XAuthController xAuthController = Get.find<XAuthController>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect Accounts"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Connect your social accounts",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Choose a platform to connect. More integrations are coming soon.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 32),

          SocialPlatformCard(
            icon: "𝕏",
            title: "X",
            subtitle: "Schedule and publish posts",
            enabled: true,
            buttonText: "Connect",
            onPressed: xAuthController.connectToX,
          ),

          const SizedBox(height: 16),

          const SocialPlatformCard(
            icon: "📷",
            title: "Instagram",
            subtitle: "Photos, reels and stories",
            enabled: false,
          ),

          const SizedBox(height: 16),

          const SocialPlatformCard(
            icon: "in",
            title: "LinkedIn",
            subtitle: "Professional posts",
            enabled: false,
          ),

          const SizedBox(height: 16),

          const SocialPlatformCard(
            icon: "f",
            title: "Facebook",
            subtitle: "Pages and timelines",
            enabled: false,
          ),
        ],
      ),
    );
  }
}