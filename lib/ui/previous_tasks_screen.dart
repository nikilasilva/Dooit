import 'package:DooIt/providers/task_provider.dart';
import 'package:DooIt/utils/app_styles.dart';
import 'package:DooIt/widgets/bottom_navbar.dart';
import 'package:DooIt/widgets/custom_confirmation_dialog.dart';
import 'package:DooIt/widgets/custom_header.dart';
import 'package:DooIt/widgets/loading_overlay.dart';
import 'package:DooIt/widgets/skeleton_task_tile.dart';
import 'package:DooIt/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviousTasksScreen extends StatefulWidget {
  const PreviousTasksScreen({super.key});

  @override
  State<PreviousTasksScreen> createState() => _PreviousTasksScreenState();
}

class _PreviousTasksScreenState extends State<PreviousTasksScreen> {
  // Show the custom input dialog for delete
  void _showDeletePrevTasksDialog(TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomConfirmationDialog(
          title: "Delete all completed tasks?",
          message: "Completed tasks will be permanently deleted",
          onSubmit: () {
            taskProvider.deleteCompletedPreviousTasks();
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final now = DateTime.now();
            final startOfToday = DateTime(now.year, now.month, now.day);
            final previousTasks =
                taskProvider.tasks.where((task) {
                  return task.dueDate != null &&
                      task.dueDate!.isBefore(startOfToday);
                }).toList();

            return LoadingOverlay(
              isLoading: taskProvider.isLoading,
              message: "Deleting previous tasks...",
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeader(title: 'Previous Tasks'),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (taskProvider.isLoading)
                            // Handle the loading state
                            ...List.generate(3, (index) => SkeletonTaskTile()),

                          // Handle the empty state
                          if (!taskProvider.isLoading && previousTasks.isEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 48),
                              alignment: Alignment.center,
                              child: Text(
                                "No previous tasks found.",
                                style: AppTextStyles.descriptionText,
                              ),
                            ),

                          // Display the list of previous tasks dynamically
                          if (!taskProvider.isLoading &&
                              previousTasks.isNotEmpty)
                            ...previousTasks.map(
                              (task) => GestureDetector(
                                onTap:
                                    () =>
                                        taskProvider.toggleTaskCompletion(task),
                                child: TaskTile(
                                  title: task.title,
                                  time: task.time,
                                  category: task.category,
                                  done: task.isCompleted,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Conditionally show the delete button only if there are completed previous tasks
                    if (!taskProvider.isLoading &&
                        previousTasks.any((task) => task.isCompleted))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              _showDeletePrevTasksDialog(taskProvider);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: AppColors.red,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Delete all completed tasks',
                                  style: AppTextStyles.cancelText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
