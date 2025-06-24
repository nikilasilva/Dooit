import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/loading_overlay.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  DateTime todayDate = DateTime.now();
  // Helper to check if two DateTime objects are on the same day
  bool _isSameDay(DateTime? a, DateTime b) {
    if (a == null) {
      return false; // If a task has no due date, it can't match.
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void initState() {
    super.initState();
    // Load tasks when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).loadTasks();
    });
  }

  String _formatTime(String time) {
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final allTasks = taskProvider.tasks;
        final todayTasks =
            allTasks
                .where((task) => _isSameDay(task.dueDate, todayDate))
                .toList();
        return LoadingOverlay(
          isLoading: taskProvider.isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            bottomNavigationBar: BottomNavbar(currentIndex: 0),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeader(title: 'All Tasks'),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 15,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/previous_tasks');
                          },
                          style: AppButtonStyles.outlineButton,
                          child: const Text(
                            'Previous Tasks',
                            style: AppTextStyles.buttonTextPrimary,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Tasks",
                            style: AppTextStyles.subHeading2,
                          ),
                          const SizedBox(height: 16),

                          if (todayTasks.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 25.0),
                                child: Text(
                                  'No tasks yet. Add a task to get started!',
                                  style: AppTextStyles.descriptionText,
                                ),
                              ),
                            )
                          else
                            ...todayTasks
                                .map(
                                  (task) => GestureDetector(
                                    onTap: () {
                                      taskProvider.toggleTaskCompletion(task);
                                    },
                                    child: TaskTile(
                                      title: task.title,
                                      time: _formatTime(task.time),
                                      category: task.category,
                                      done: task.isCompleted,
                                    ),
                                  ),
                                )
                                .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
