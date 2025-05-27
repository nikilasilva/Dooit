import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/category_button.dart';
import 'package:dooit/widgets/profile_image.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: AppColors.white, // Set the overall background to white
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // Change header background color
                color: AppColors.secondary,
                padding: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello,", style: AppTextStyles.headingDark),
                        Row(
                          children: [
                            Text("Nathan !", style: AppTextStyles.heading),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${today.day} ${_monthName(today.month)} ${today.year} (${_weekday(today.weekday)})",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(height: 8),
                        Text("Your progress", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 4),
                      ],
                    ),
                    ProfileImage(
                      imagePath: "assets/images/pro_img.jpg",
                      fallbackText: "Profile Icon",
                      borderColor: AppColors.primary,
                      size: 110.0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Categories with separate padding
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 22,
                ), // Padding for categories
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: AppTextStyles.subHeading2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/categories');
                          },
                          child: Text(
                            "see all",
                            style: TextStyle(color: AppColors.grey1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryButton(icon: Icons.work, label: "Work"),
                        CategoryButton(icon: Icons.person, label: "Personal"),
                        CategoryButton(
                          icon: Icons.shopping_cart,
                          label: "Shopping",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Tasks with separate padding
              Container(
                padding: EdgeInsets.all(22), // Padding for tasks
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Tasks",
                          style: AppTextStyles.subHeading2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/all_tasks');
                          },
                          child: Text(
                            "see all",
                            style: TextStyle(color: AppColors.grey1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
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
    return months[month - 1];
  }

  String _weekday(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
