import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class TodayTasks extends StatelessWidget {
  final DateTime selectedDate;

  const TodayTasks({super.key, required this.selectedDate});

  List<Map<String, dynamic>> _getTasksForDate(DateTime date) {
    // Simulate tasks for the selected date
    if (date.day % 3 == 0) {
      return [
        {'title': 'Morning workout', 'time': '7:00 AM', 'category': 'Health'},
        {'title': 'Team meeting', 'time': '10:00 AM', 'category': 'Work'},
        {
          'title': 'Grocery shopping',
          'time': '6:00 PM',
          'category': 'Personal',
        },
      ];
    } else if (date.day % 7 == 0) {
      return [
        {'title': 'Review project', 'time': '2:00 PM', 'category': 'Work'},
        {'title': 'Call mom', 'time': '7:00 PM', 'category': 'Personal'},
      ];
    }
    return [];
  }

  String _formatDate(DateTime date) {
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
    final tasks = _getTasksForDate(selectedDate);

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

          if (tasks.isEmpty)
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Center(
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
                      "Tap + to add a new task",
                      style: AppTextStyles.descriptionText.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...tasks
                .map(
                  (task) => TaskTile(
                    title: task['title'],
                    time: task['time'],
                    category: task['category'],
                  )
                ),
        ],
      ),
    );
  }
}
