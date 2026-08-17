import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/posts_controller.dart';
import '../models/post_view_response.dart';
import 'status_chip.dart';

class PostCard extends StatelessWidget {
  final PostViewResponse post;
  final PostsController postsController;
  final bool showActions;

  const PostCard({
    super.key,

    required this.post,

    required this.postsController,

    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    DateTime? scheduledDate;

    if (post.scheduledAtUtc != null) {
      scheduledDate = DateTime.parse(post.scheduledAtUtc!);
    }

    return Card(
      elevation: 0,

      margin: const EdgeInsets.only(bottom: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),

        side: BorderSide(color: colors.outline),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 42,

                  height: 42,

                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(.15),

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Icon(
                    post.status == "published"
                        ? Icons.check_circle_outline
                        : Icons.schedule,

                    color: colors.primary,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  post.status.toUpperCase(),

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(post.content, style: Theme.of(context).textTheme.bodyLarge),

            const SizedBox(height: 20),

            Divider(color: colors.outline),

            const SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  scheduledDate != null ? Icons.access_time : Icons.send,

                  size: 18,

                  color: colors.onSurfaceVariant,
                ),

                const SizedBox(width: 8),

                Text(
                  scheduledDate != null
                      ? DateFormat.yMMMd().add_jm().format(
                          scheduledDate.toLocal(),
                        )
                      : "Published",

                  style: TextStyle(color: colors.onSurfaceVariant),
                ),

                const Spacer(),

                if (showActions) ...[
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),

                    onPressed: () {
                      Get.toNamed(AppRoutes.schedule, arguments: post);
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete_outline),

                    onPressed: () {
                      postsController.deletePost(post.id);
                    },
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
