import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/skeleton_task_tile.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTasksScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryTasksScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            // Filter tasks by selected category
            final categoryTasks = taskProvider.tasks.where((task) => task.category == categoryName).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(title: "$categoryName Tasks"),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (taskProvider.isLoading)
                            ...List.generate(3, (index) => SkeletonTaskTile()),

                          if (!taskProvider.isLoading && categoryTasks.isEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 48),
                              alignment: Alignment.center,
                              child: Text(
                                "No tasks found in this category",
                                style: AppTextStyles.descriptionText,
                              ),
                            ),

                          if (!taskProvider.isLoading &&
                              categoryTasks.isNotEmpty)
                            ...categoryTasks.map(
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
