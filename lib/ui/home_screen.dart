import 'package:dooit/providers/auth_provider.dart';
import 'package:dooit/providers/category_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/category_button.dart';
import 'package:dooit/widgets/profile_image.dart';
import 'package:dooit/widgets/skeleton_category.dart';
import 'package:dooit/widgets/skeleton_text.dart';
import 'package:dooit/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:change_case/change_case.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Widget _buildCategorySkeletons() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [SkeletonCategory(), SkeletonCategory(), SkeletonCategory()],
    );
  }

  Future<void> _loadUserData() async {
    // Use a post-frame callbackto avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        final displayName = authProvider.user!.displayName;
        final email = authProvider.user!.email;

        setState(() {
          // If display name exists, use it; otherwise use the first part of email
          String rawName =
              displayName != null && displayName.isNotEmpty
                  ? displayName
                  : email != null
                  ? email.split('@')[0]
                  : 'User';
          _username = rawName.toTitleCase();
          _isLoading = false;
        });
      } else {
        setState(() {
          _username = "User";
          _isLoading = false;
        });
      }
    });
  }

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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello,", style: AppTextStyles.headingDark),
                          Row(
                            children: [
                              // Show loading indicator or username
                              _isLoading
                                  ? const SkeletonText(width: 100, height: 28)
                                  : Flexible(
                                    child: Text(
                                      "$_username !",
                                      style: AppTextStyles.heading,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${today.day} ${_monthName(today.month)} ${today.year} (${_weekday(today.weekday)})",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
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
                        Text("Categories", style: AppTextStyles.subHeading2),
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

                    Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        if (categoryProvider.isLoading) {
                          return _buildCategorySkeletons();
                        }
                        final displayedCategories =
                            categoryProvider.categories.take(3).toList();

                        if (displayedCategories.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text("No categories available."),
                            ),
                          );
                        }

                        // Build the category buttons dynamically
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: displayedCategories.map((category) {
                            return CategoryButton(
                              icon: category['icon'],
                              label: category['label'],
                              id: category['id'],
                              onTap: () {
                                // Navigate to the full categories screen or a filtered task list
                                Navigator.pushNamed(context, '/categories');
                              },
                            );
                          }).toList(),
                        );
                      },
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
                        Text("Today's Tasks", style: AppTextStyles.subHeading2),
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
                      category: "Health",
                      done: false,
                    ),
                    TaskTile(
                      title: "Project meeting",
                      time: "03:00 pm",
                      category: "Work",
                      done: false,
                    ),
                    TaskTile(
                      title: "Dinner with Josh at 8pm",
                      time: "02:00 am",
                      category: "Work",
                      done: false,
                    ),
                    TaskTile(
                      title: "Game meetup",
                      time: "08:00 pm",
                      category: "Personal",
                      done: false,
                    ),
                    TaskTile(
                      title: "Take out trash",
                      time: "10:00 am",
                      category: "Personal",
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
