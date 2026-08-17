import 'package:flutter/material.dart';

class SocialPlatformCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final String buttonText;
  final VoidCallback? onPressed;

  const SocialPlatformCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    this.buttonText = "Coming Soon",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Opacity(
      opacity: enabled ? 1 : .55,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: colors.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    icon,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              enabled
                  ? FilledButton(
                onPressed: onPressed,
                child: Text(buttonText),
              )
                  : OutlinedButton(
                onPressed: null,
                child: const Text("Coming Soon"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}