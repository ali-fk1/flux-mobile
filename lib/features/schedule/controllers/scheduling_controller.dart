import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../posts/models/post_view_response.dart';
import '../repositories/scheduling_repository.dart';

class SchedulingController extends GetxController {
  final SchedulingRepository _schedulingRepository;

  SchedulingController(this._schedulingRepository);

  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;

  final postText = "".obs;
  final textController = TextEditingController();

  final selectedPlatform = "X".obs;

  final isLoading = false.obs;
  final isLoadingP = false.obs;

  final editingPost = Rxn<PostViewResponse>();

  bool get isEditing => editingPost.value != null;

  @override
  void onInit() {
    super.onInit();

    textController.addListener(() {
      postText.value = textController.text;
    });

    if (Get.arguments != null) {
      editingPost.value = Get.arguments as PostViewResponse;

      textController.text = editingPost.value!.content;

      if (editingPost.value!.scheduledAtUtc != null) {
        final date = DateTime.parse(editingPost.value!.scheduledAtUtc!);

        selectedDate.value = date;

        selectedTime.value = TimeOfDay.fromDateTime(date);
      }
    }
  }

  @override
  void onClose() {
    textController.dispose();

    super.onClose();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = DateTime(
      date.year,
      date.month,
      date.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );
  }

  Future<void> pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (picked != null) {
      selectedTime.value = picked;

      selectedDate.value = DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        picked.hour,
        picked.minute,
      );
    }
  }

  bool isPastTime() {
    return selectedDate.value.isBefore(DateTime.now());
  }

  Future<void> submitPost() async {
    try {
      isLoading.value = true;

      await _schedulingRepository.createScheduledPost(
        platform: selectedPlatform.value,
        text: postText.value,
        localDateTime: selectedDate.value,
      );

      Get.snackbar("Success", "Post scheduled successfully!");

      Get.offAllNamed(AppRoutes.posts);
    } catch (e) {
      Get.snackbar("Error", "Failed to schedule post: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePost() async {
    if (editingPost.value == null) {
      Get.snackbar("Error", "No post selected for editing");

      return;
    }

    try {
      isLoading.value = true;

      await _schedulingRepository.updateScheduledPost(
        postId: editingPost.value!.id,
        text: postText.value,
        localDateTime: selectedDate.value,
      );

      Get.snackbar("Success", "Post updated successfully!");

      Get.offAllNamed(AppRoutes.posts);
    } catch (e) {
      Get.snackbar("Error", "Failed to update post: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postNow() async {
    try {
      isLoadingP.value = true;

      await _schedulingRepository.postNow(text: postText.value);

      Get.snackbar("Success", "Posted successfully!");

      Get.offAllNamed(AppRoutes.posts);
    } catch (e) {
      Get.snackbar("Error", "Failed to post: $e");
    } finally {
      isLoadingP.value = false;
    }
  }
}
