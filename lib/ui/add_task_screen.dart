import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_dropdown_field.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: BottomNavbar(currentIndex: 2),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(title: 'New Task'),
                Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ), // Add padding around all form fields
                  child: Column(
                    children: [
                      SizedBox(height: 2),
                      CustomInputField(
                        label: 'Title',
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 16),
                      CustomDropdownField(
                        label: 'Category',
                        items: const ['Work', 'Personal', 'Shopping'],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomInputField(
                              label: 'Date',
                              isDateField: true,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: CustomInputField(
                              label: 'Time',
                              isTimeField: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      CustomInputField(
                        label: 'Note',
                        keyboardType: TextInputType.multiline,
                      ),

                      SizedBox(height: 16),
                      ActionButtonsRow(
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        onSubmit: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
