import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/calendar_grid.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/month_header.dart';
import 'package:dooit/widgets/today_tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();

  // Helper to check if two DateTime objects are on the same day
  bool _isSameDay(DateTime? a, DateTime b) {
    if (a == null) {
      return false; // If a task has no due date, it can't match.
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final alltasks = taskProvider.tasks;
            final tasksForSelectedDate =
                alltasks
                    .where((task) => _isSameDay(task.dueDate, selectedDate))
                    .toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomHeader(title: "Calendar"),
                  SizedBox(height: 20),

                  MonthHeader(
                    currentMonth: currentMonth,
                    onPreviousMonth: () {
                      setState(() {
                        currentMonth = DateTime(
                          currentMonth.year,
                          currentMonth.month - 1,
                        );
                      });
                    },
                    onNextMonth: () {
                      setState(() {
                        currentMonth = DateTime(
                          currentMonth.year,
                          currentMonth.month + 1,
                        );
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  CalendarGrid(
                    currentMonth: currentMonth,
                    selectedDate: selectedDate,
                    allTasks: alltasks,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),

                  SizedBox(height: 30),

                  TodayTasks(selectedDate: selectedDate, tasksForSelectedDate: tasksForSelectedDate,),

                  SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
