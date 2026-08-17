import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../models/post_status.dart';
import '../models/post_view_response.dart';
import '../repositories/post_repository.dart';

enum PostsTab { scheduled, sent }

class PostsController extends GetxController {
  final PostRepository _postRepository;

  PostsController(this._postRepository);

  final posts = <PostViewResponse>[].obs;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  final Rx<PostsTab> selectedTab = PostsTab.scheduled.obs;

  String? _nextCursor;

  bool _hasNext = true;

  @override
  void onInit() {
    super.onInit();

    loadInitial(PostStatus.scheduled);
  }

  @override
  void onReady() {
    super.onReady();

    refresh();
  }

  Future<void> loadInitial(PostStatus status) async {
    try {
      isLoading.value = true;

      posts.clear();

      _nextCursor = null;

      _hasNext = true;

      final page = await _postRepository.getPosts(status: status);

      debugPrint("Loading status: $status");

      debugPrint("Posts fetched: ${page.content.length}");

      posts.assignAll(page.content);

      _nextCursor = page.nextCursor;

      _hasNext = page.hasNext;
    } catch (e) {
      debugPrint("Loading posts failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore(PostStatus status) async {
    if (isLoadingMore.value || !_hasNext || _nextCursor == null) {
      return;
    }

    try {
      isLoadingMore.value = true;

      final page = await _postRepository.getPosts(
        status: status,
        cursor: _nextCursor,
      );

      posts.addAll(page.content);

      _nextCursor = page.nextCursor;

      _hasNext = page.hasNext;
    } catch (e) {
      debugPrint("Loading more failed: $e");
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refresh() {
    final status = selectedTab.value == PostsTab.scheduled
        ? PostStatus.scheduled
        : PostStatus.published;

    return loadInitial(status);
  }

  Future<void> switchTab(PostsTab tab) async {
    selectedTab.value = tab;

    final status = tab == PostsTab.scheduled
        ? PostStatus.scheduled
        : PostStatus.published;

    await loadInitial(status);
  }

  Future<void> deletePost(String postId) async {
    try {
      await _postRepository.deleteScheduledPost(postId: postId);

      posts.removeWhere((post) => post.id == postId);

      Get.snackbar("Success", "Post deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed deleting post: $e");
    }
  }

  Future<void> logout() async {
    final storage = Get.find<SecureStorageService>();

    await storage.clear();

    Get.offAllNamed(AppRoutes.login);
  }
}
