import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/daily_productivity_map.dart';
import 'package:dooit/widgets/progress_stats.dart';
import 'package:dooit/widgets/tasks_by_category.dart';
import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(title: "Progress"),
              SizedBox(height: 30),
              
              // Progress Stats Section
              ProgressStats(),
              
              SizedBox(height: 32),
              
              // Daily Productivity Map Section
              DailyProductivityMap(),
              
              SizedBox(height: 32),
              
              // Tasks by Category Section
              TasksByCategory(),
              
              SizedBox(height: 100), // Bottom padding for navigation bar
            ],
          ),
        ),
      ),
    );
  }
}