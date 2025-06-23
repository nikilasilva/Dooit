import 'package:dooit/models/task.dart';
import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/skeleton_task_tile.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayTasks extends StatelessWidget {
  final DateTime selectedDate;
  final List<Task> tasksForSelectedDate;

  const TodayTasks({
    super.key,
    required this.selectedDate,
    required this.tasksForSelectedDate,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    }
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    // This variable is defined outside the consumer, which is correct.
    final tasks = tasksForSelectedDate;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Tasks for ", style: AppTextStyles.subHeadingDark),
              Text(_formatDate(selectedDate), style: AppTextStyles.subHeading2),
            ],
          ),
          SizedBox(height: 16),
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              // If the provider is loading, show a skeleton.
              if (taskProvider.isLoading) {
                return SkeletonTaskTile();
              }

              // If not loading, check if the passed-in list is empty.
              if (tasks.isEmpty) {
                // If empty, show the "No tasks" widget.
                return Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/add_task');
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 12),
                          Text(
                            "No tasks scheduled",
                            style: AppTextStyles.descriptionText,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Tap to add a new task",
                            style: AppTextStyles.descriptionText.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // If not loading and not empty, show the list of tasks.
              return Column(
                children:
                    tasks.map((task) {
                      return GestureDetector(
                        onTap: () => taskProvider.toggleTaskCompletion(task),
                        child: TaskTile(
                          title: task.title,
                          time: task.time,
                          category: task.category,
                          done: task.isCompleted,
                        ),
                      );
                    }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
