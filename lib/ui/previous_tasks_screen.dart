import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_confirmation_dialog.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class PreviousTasksScreen extends StatefulWidget {
  const PreviousTasksScreen({super.key});

  @override
  State<PreviousTasksScreen> createState() => _PreviousTasksScreenState();
}

class _PreviousTasksScreenState extends State<PreviousTasksScreen> {
  // Show the custom input dialog for delete
  void _showDeletePrevTasksDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomConfirmationDialog(
          title: "Delete all completed tasks?",
          message: "Completed tasks will be permanently deleted",
          onSubmit: () {},
        );
      },
    );
  }

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
              CustomHeader(title: 'Previous Tasks'),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskTile(
                      title: "Water the plants",
                      time: "12:00 pm",
                      done: false,
                    ),
                    TaskTile(
                      title: "Project meeting",
                      time: "03:00 pm",
                      done: false,
                    ),
                    TaskTile(
                      title: "Abs workout",
                      time: "04:00 am",
                      done: false,
                    ),
                    TaskTile(
                      title: "Brainstrom ideas for the project",
                      time: "02:00 am",
                      done: true,
                    ),
                    TaskTile(
                      title: "Feed the dog",
                      time: "03:00 am",
                      done: true,
                    ),
                    TaskTile(title: "Buy milk", time: "08:00 am", done: true),
                    TaskTile(title: "Send email", time: "07:30 am", done: true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _showDeletePrevTasksDialog();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete_forever,
                          color: AppColors.red,
                          size: 16,
                        ),
                        Text(
                          'Delete all completed tasks',
                          style: AppTextStyles.cancelText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
