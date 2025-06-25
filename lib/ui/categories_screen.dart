import 'package:DooIt/providers/category_provider.dart';
import 'package:DooIt/utils/app_styles.dart';
import 'package:DooIt/utils/snackbar_helper.dart';
import 'package:DooIt/widgets/bottom_navbar.dart';
import 'package:DooIt/widgets/category_grid.dart';
import 'package:DooIt/widgets/custom_header.dart';
import 'package:DooIt/widgets/custom_input_dialog.dart';
import 'package:DooIt/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  // Show the custom input dialog
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return CustomInputDialog(
          title: "Category Title",
          hintText: "Enter category name",
          onSubmit: (value) async {
            final categoryProvider = Provider.of<CategoryProvider>(
              context,
              listen: false,
            );
            final success = await categoryProvider.addCategory(value);

            if (!mounted) return;

            if (success) {
              SnackbarHelper.showSuccessSnackBar(
                context,
                "Category added successfully!",
              );
            } else {
              SnackbarHelper.showErrorSnackBar(
                context,
                categoryProvider.errorMessage ?? "Failed to add category",
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return LoadingOverlay(
          isLoading: categoryProvider.isLoading,
          message: "Loading categories",
          child: Scaffold(
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
                          child: categoryProvider.categories.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                                    child: Text(
                                      'No categories yet. Add a category to get started!',
                                      style: AppTextStyles.descriptionText,
                                    ),
                                  ),
                                ):
                          CategoryGrid(categories: categoryProvider.categories),
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
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
