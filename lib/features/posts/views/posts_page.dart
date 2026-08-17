import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../auth/controllers/x_auth_controller.dart';
import '../controllers/posts_controller.dart';
import '../models/post_status.dart';
import '../widgets/post_card.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsController controller = Get.find();
  final XAuthController xAuthController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 250) {
        controller.loadMore(
          controller.selectedTab.value == PostsTab.scheduled
              ? PostStatus.scheduled
              : PostStatus.published,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSettingsSheet(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ListTile(
            leading: Icon(Icons.logout, color: colors.error),
            title: Text(
              "Log out",
              style: TextStyle(
                color: colors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.of(ctx).pop();
              controller.logout();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          Obx(() {
            final info = xAuthController.accountInfo.value;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: colors.secondary,
                  backgroundImage: info?.profileImageUrl != null
                      ? NetworkImage(info!.profileImageUrl!)
                      : null,
                  child: info?.profileImageUrl == null
                      ? Icon(Icons.person, color: colors.onSecondary, size: 18)
                      : null,
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          "𝕏",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(width: 10),
          Expanded(
            child: Obx(() {
              final info = xAuthController.accountInfo.value;
              return Text(
                info?.username != null ? "@${info!.username}" : "X account",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              );
            }),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: "Settings",
            onPressed: () => _showSettingsSheet(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Widget tabButton(String label, PostsTab tab) {
      return Expanded(
        child: Obx(() {
          final selected = controller.selectedTab.value == tab;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,

            onTap: () async {
              if (!selected) {
                await controller.switchTab(tab);
              } else {
                await controller.refresh();
              }
            },

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),

                  child: Text(
                    label,

                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,

                      color: selected
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                  ),
                ),

                Container(
                  height: 2.5,

                  color: selected ? colors.primary : Colors.transparent,
                ),
              ],
            ),
          );
        }),
      );
    }

    return Row(
      children: [
        tabButton("Scheduled", PostsTab.scheduled),

        tabButton("Sent", PostsTab.sent),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, {required bool isSent}) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        const SizedBox(height: 140),
        Icon(
          isSent ? Icons.check_circle_outline : Icons.schedule,
          size: 72,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 20),
        Text(
          isSent ? "No posts sent yet" : "No scheduled posts",
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          isSent
              ? "Posts you've published will appear here."
              : "Posts you schedule will appear here.",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduledList(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.posts.isEmpty) {
        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: _buildEmptyState(context, isSent: false),
        );
      }
      return RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount:
              controller.posts.length +
              (controller.isLoadingMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.posts.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return PostCard(
              post: controller.posts[index],
              postsController: controller,
              showActions: true,
            );
          },
        ),
      );
    });
  }

  Widget _buildSentList(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.posts.isEmpty) {
        return _buildEmptyState(context, isSent: true);
      }

      return RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount:
              controller.posts.length +
              (controller.isLoadingMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.posts.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return PostCard(
              post: controller.posts[index],
              postsController: controller,
              showActions: false,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabSwitcher(context),
            Divider(height: 1, color: theme.colorScheme.outline),
            Expanded(
              child: Obx(() {
                return controller.selectedTab.value == PostsTab.scheduled
                    ? _buildScheduledList(context)
                    : _buildSentList(context);
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.schedule),
        icon: const Icon(Icons.add),
        label: const Text("Schedule"),
      ),
    );
  }
}
