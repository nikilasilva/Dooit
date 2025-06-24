import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/heatmap_legend.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductivityHeatmap extends StatelessWidget {
  final Map<DateTime, int> completedTasksPerDay;

  const ProductivityHeatmap({super.key, required this.completedTasksPerDay});

  Color _getHeatmapColor(int tasks) {
    if (tasks == 0) return Color(0xFFFFECE7); // No tasks, no color
    if (tasks <= 2) return Color(0xFFFFE0D6);
    if (tasks <= 4) return Color(0xFFFFB899);
    if (tasks <= 6) return Color(0xFFFF9066);
    if (tasks <= 8) return Color(0xFFFF6B35);
    if (tasks <= 10) return Color(0xFFE55A2B);
    return Color(0xFFCC4A21);
  }

  Widget _buildWeekRow(int weekIndex, List<List<int>> monthsData) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Week label
          SizedBox(
            width: 60,
            child: Text(
              "Week ${weekIndex < 9 ? '0' : ''}${weekIndex + 1}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // First month
          Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex + 1;
                int tasksCompleted = 0;
                if (dayNumber <= 31) {
                  tasksCompleted = monthsData[0][dayNumber - 1];
                }
                return Expanded(
                  child: Container(
                    height: 16,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: _getHeatmapColor(tasksCompleted),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Space between months
          SizedBox(width: 16),

          // Second month
          Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex + 1;
                int tasksCompleted = 0;
                if (dayNumber <= 31) {
                  tasksCompleted = monthsData[1][dayNumber - 1];
                }
                return Expanded(
                  child: Container(
                    height: 16,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: _getHeatmapColor(tasksCompleted),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Space between months
          SizedBox(width: 16),

          // Third month
          Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex + 1;
                int tasksCompleted = 0;
                if (dayNumber <= 31) {
                  tasksCompleted = monthsData[2][dayNumber - 1];
                }
                return Expanded(
                  child: Container(
                    height: 16,
                    margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: _getHeatmapColor(tasksCompleted),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and calculate the last 3 months
    final now = DateTime.now();
    final months = [
      DateTime(now.year, now.month - 2, 1), // Two months ago
      DateTime(now.year, now.month - 1, 1), // Last month
      DateTime(now.year, now.month, 1), // Current month
    ];

    // Format the month names
    final monthNames =
        months.map((date) => DateFormat.MMMM().format(date)).toList();

    // For each month, pre-calculate days with tasks
    List<List<int>> monthsData = [];
    for (final month in months) {
      List<int> daysData = List.filled(31, 0); // Max days in a month

      // Get days in this month
      final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

      // Fill in the task counts for this month
      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(month.year, month.month, day);
        daysData[day - 1] = completedTasksPerDay[date] ?? 0;
      }
      monthsData.add(daysData);
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Month Headers
          Row(
            children: [
              SizedBox(width: 60), // Space for "Week XX" labels
              ...monthNames.map(
                (name) => Expanded(
                  child: Center(
                    child: Text(
                      name,
                      style: AppTextStyles.subHeadingDark.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Weeks (rows) - typically 4 weeks per month
          ...List.generate(4, (weekIndex) {
            return _buildWeekRow(weekIndex, monthsData);
          }),

          SizedBox(height: 16),

          // Legend
          HeatmapLegend(),
        ],
      ),
    );
  }
}
