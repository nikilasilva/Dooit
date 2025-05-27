import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () {},
                    style: AppButtonStyles.outlineButton,
                    child: const Text(
                      'Previous Tasks',
                      style: AppTextStyles.buttonTextPrimary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today's Tasks", style: AppTextStyles.subHeading2),
                    const SizedBox(height: 16),
                    TaskTile(
                      title: "GYM workout",
                      time: "12:00 pm",
                      done: false,
                    ),
                    TaskTile(
                      title: "Project meeting",
                      time: "03:00 pm",
                      done: false,
                    ),
                    TaskTile(
                      title: "Dinner with Josh at 8pm",
                      time: "02:00 am",
                      done: false,
                    ),
                    TaskTile(
                      title: "Game meetup",
                      time: "08:00 pm",
                      done: false,
                    ),
                    TaskTile(
                      title: "Take out trash",
                      time: "10:00 am",
                      done: true,
                    ),
                    TaskTile(
                      title: "Feed the dog",
                      time: "10:00 am",
                      done: true,
                    ),
                    TaskTile(title: "Buy milk", time: "08:00 am", done: true),
                    TaskTile(title: "Send email", time: "07:30 am", done: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
