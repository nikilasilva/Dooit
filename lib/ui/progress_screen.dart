import 'package:DooIt/providers/task_provider.dart';
import 'package:DooIt/utils/app_styles.dart';
import 'package:DooIt/widgets/bottom_navbar.dart';
import 'package:DooIt/widgets/custom_header.dart';
import 'package:DooIt/widgets/daily_productivity_map.dart';
import 'package:DooIt/widgets/progress_stats.dart';
import 'package:DooIt/widgets/tasks_by_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 3),
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final completedToday = taskProvider.completedTasksToday;
            final totalToday = taskProvider.totalTasksToday;
            final streak = taskProvider.completionStreak;

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomHeader(title: "Progress"),
                  SizedBox(height: 30),

                  // Progress Stats Section
                  ProgressStats(
                    completedToday: completedToday,
                    totalToday: totalToday,
                    streak: streak,
                  ),

                  SizedBox(height: 32),

                  // Daily Productivity Map Section
                  DailyProductivityMap(),

                  SizedBox(height: 32),

                  // Tasks by Category Section
                  TasksByCategory(),

                  SizedBox(height: 100), // Bottom padding for navigation bar
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
