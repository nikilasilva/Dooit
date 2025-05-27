import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/category_grid.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/custom_input_dialog.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> categories = [
    {'icon': Icons.work, 'label': "Work"},
    {'icon': Icons.person, 'label': "Personal"},
    {'icon': Icons.shopping_cart, 'label': "Shopping"},
    {'icon': Icons.monitor_heart_rounded, 'label': "Health"},
    {'icon': Icons.home, 'label': "Home"},
    {'icon': Icons.family_restroom, 'label': "Family"},
  ];

  // Show the custom input dialog
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return CustomInputDialog(
          title: "Category Title",
          hintText: "Enter category name",
          onSubmit: (value) {
            setState(() {
              categories.add({'icon': Icons.category, 'label': value});
            });
          },
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(title: 'Categories'),
                  SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: CategoryGrid(categories: categories),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
            // Add Category Button
            Positioned(
              bottom: 10,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  _showAddCategoryDialog();
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: AppColors.white, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
