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
                        vertical: 8,
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
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Tasks",
                            style: AppTextStyles.subHeading2,
                          ),
                          const SizedBox(height: 16),

                          if (taskProvider.tasks.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 32.0),
                                child: Text(
                                  'No tasks yet. Add a task to get started!',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          else
                            ...taskProvider.tasks
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

                          // TaskTile(
                          //   title: "GYM workout",
                          //   time: "12:00 pm",
                          //   category: "Health",
                          //   done: false,
                          // ),
                          // TaskTile(
                          //   title: "Project meeting",
                          //   time: "03:00 pm",
                          //   category: "Work",
                          //   done: false,
                          // ),
                          // TaskTile(
                          //   title: "Dinner with Josh at 8pm",
                          //   time: "02:00 am",
                          //   category: "Personal",
                          //   done: false,
                          // ),
                          // TaskTile(
                          //   title: "Game meetup",
                          //   time: "08:00 pm",
                          //   category: "Personal",
                          //   done: false,
                          // ),
                          // TaskTile(
                          //   title: "Take out trash",
                          //   time: "10:00 am",
                          //   category: "Personal",
                          //   done: true,
                          // ),
                          // TaskTile(
                          //   title: "Feed the dog",
                          //   time: "10:00 am",
                          //   category: "Personal",
                          //   done: true,
                          // ),
                          // TaskTile(title: "Buy milk", time: "08:00 am", category: "Personal", done: true),
                          // TaskTile(title: "Send email", time: "07:30 am", category: "Work", done: true),
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
