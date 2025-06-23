import 'package:dooit/models/task.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final List<Task> allTasks;

  const CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onDateSelected,
    required this.allTasks,
  });

  // Helper to check if two DateTime objects are on the same day
  bool _isSameDay(DateTime? a, DateTime b) {
    if (a == null) {
      return false; // If a task has no due date, it can't match.
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<DateTime> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    final firstDayWeekday = firstDayOfMonth.weekday;

    List<DateTime> days = [];

    // Add days from previous month to fill the first week
    for (int i = firstDayWeekday - 1; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    // Add all days of current month
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      days.add(DateTime(currentMonth.year, currentMonth.month, day));
    }

    // Add days from next month to fill the last week
    int remainingDays = 42 - days.length; // 6 weeks * 7 days
    for (int day = 1; day <= remainingDays; day++) {
      days.add(DateTime(currentMonth.year, currentMonth.month + 1, day));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Weekday headers
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children:
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      .map(
                        (day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: AppTextStyles.descriptionText.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          // Calendar days grid
          ...List.generate(6, (weekIndex) {
            return Row(
              children: List.generate(7, (dayIndex) {
                final dayDate = days[weekIndex * 7 + dayIndex];
                final isCurrentMonth = dayDate.month == currentMonth.month;
                final isSelected =
                    dayDate.day == selectedDate.day &&
                    dayDate.month == selectedDate.month &&
                    dayDate.year == selectedDate.year;
                final isToday = _isSameDay(dayDate, DateTime.now());
                final hasTasks = allTasks.any(
                  (task) => _isSameDay(task.dueDate, dayDate)
                );

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onDateSelected(dayDate),
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primary
                                : isToday
                                ? AppColors.primary.withOpacity(0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${dayDate.day}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  isToday ? FontWeight.bold : FontWeight.normal,
                              color:
                                  isSelected
                                      ? Colors.white
                                      : isCurrentMonth
                                      ? Colors.black
                                      : Colors.grey[400],
                            ),
                          ),
                          if (hasTasks && !isSelected)
                            Container(
                              width: 4,
                              height: 4,
                              margin: EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}
