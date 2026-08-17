import 'package:flutter/material.dart';
import 'package:flux_mobile/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.rocket_launch_rounded,
                      size: 42,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    "Flux",
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Manage and schedule your social media content from one place.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Secure authentication powered by Keycloak.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: Obx(
                          () => ElevatedButton.icon(
                        onPressed: authController.isLoading.value
                            ? null
                            : () => authController.login(),
                        icon: authController.isLoading.value
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        )
                            : const Icon(Icons.login),
                        label: Text(
                          authController.isLoading.value
                              ? "Redirecting..."
                              : "Sign In",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        authController.register();
                      },
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text("Create Account"),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "OAuth2 Authorization Code + PKCE",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Flux v1.0.0",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}