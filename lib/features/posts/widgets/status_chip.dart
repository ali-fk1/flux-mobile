import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status.toLowerCase()) {
      case "scheduled":
        color = Colors.orange;

        break;

      case "processing":
      case "publishing":
        color = Colors.blue;

        break;

      case "published":
        color = Colors.green;

        break;

      case "failed":
        color = Colors.red;

        break;

      case "cancelled":
        color = Colors.grey;

        break;

      default:
        color = Theme.of(context).colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

      decoration: BoxDecoration(
        color: color.withOpacity(.15),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        status.toUpperCase(),

        style: TextStyle(
          color: color,

          fontWeight: FontWeight.w600,

          fontSize: 12,
        ),
      ),
    );
  }
}
