import 'package:flutter/material.dart';
import 'package:flux_mobile/features/schedule/controllers/scheduling_controller.dart';
import 'package:get/get.dart';

class SchedulingPage extends StatelessWidget {
  SchedulingPage({super.key});

  final SchedulingController schedulingController =
      Get.find<SchedulingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            schedulingController.isEditing ? "Edit Post" : "Schedule Post",
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: schedulingController.textController,
                maxLength: 280,
                decoration: const InputDecoration(
                  hintText: 'What do you want to share today',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Card(
              elevation: 2,
              margin: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 350,
                child: Obx(
                  () => CalendarDatePicker(
                    initialDate: schedulingController.selectedDate.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    onDateChanged: schedulingController.updateSelectedDate,
                  ),
                ),
              ),
            ),

            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Selected Date: "
                  "${schedulingController.selectedDate.value.year}-"
                  "${schedulingController.selectedDate.value.month}-"
                  "${schedulingController.selectedDate.value.day}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.access_time, color: Colors.blue),

                title: const Text("Select Posting Time"),

                trailing: Obx(
                  () => Text(
                    schedulingController.selectedTime.value.format(context),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                onTap: () => schedulingController.pickTime(context),
              ),
            ),

            const SizedBox(height: 16),

            Obx(
              () => schedulingController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (schedulingController.postText.value
                            .trim()
                            .isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter some text to post!",
                          );

                          return;
                        }

                        if (schedulingController.isPastTime()) {
                          Get.snackbar(
                            "Error",
                            "You cannot schedule a post in the past!",
                          );

                          return;
                        }

                        if (schedulingController.isEditing) {
                          schedulingController.updatePost();
                        } else {
                          schedulingController.submitPost();
                        }
                      },

                      child: Text(
                        schedulingController.isEditing
                            ? "Save Changes"
                            : "Confirm Schedule",
                      ),
                    ),
            ),
            const SizedBox(height: 24),

            Obx(
              () => schedulingController.isLoadingP.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        schedulingController.postNow();
                      },
                      child: Text("Post now"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
