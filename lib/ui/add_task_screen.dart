import 'package:dooit/providers/category_provider.dart';
import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/utils/snackbar_helper.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_dropdown_field.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:dooit/widgets/custom_input_field.dart';
import 'package:dooit/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedCategory = 'Personal';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    // When the screen loads, tell the categoryProvider to fetch user categories.
    // We use addPostFrameCallback to ensure the context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).updateUser();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleAddTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // Format time as string
    final formattedTime =
        '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}';

    final success = await taskProvider.addTask(
      title: _titleController.text.trim(),
      category: _selectedCategory,
      date: _selectedDate,
      time: formattedTime,
      note: _noteController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      SnackbarHelper.showSuccessSnackBar(context, "Task added successfully!");
      Navigator.pushReplacementNamed(context, '/all_tasks');
    } else {
      SnackbarHelper.showErrorSnackBar(
        context,
        taskProvider.errorMessage ?? "Failed to add task",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskProvider, CategoryProvider>(
      builder: (context, taskProvider, categoryProvider, child) {
        final categoryItems = categoryProvider.categories.map((cat) => cat['label'] as String).toList();
        return LoadingOverlay(
          isLoading: taskProvider.isLoading,
          message: "Adding task...",
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColors.white,
              bottomNavigationBar: BottomNavbar(currentIndex: 2),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                                controller: _titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a task title";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              CustomDropdownField(
                                label: 'Category',
                                items: categoryItems,
                                initialValue: _selectedCategory,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _selectedCategory = newValue;
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomInputField(
                                      label: 'Date',
                                      isDateField: true,
                                      initialDate: _selectedDate,
                                      onDateSelected: (date) {
                                        if (date != null) {
                                          setState(() {
                                            _selectedDate = date;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomInputField(
                                      label: 'Time',
                                      isTimeField: true,
                                      initialTime: _selectedTime,
                                      onTimeSelected: (time) {
                                        if (time != null) {
                                          setState(() {
                                            _selectedTime = time;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              CustomInputField(
                                label: 'Note',
                                keyboardType: TextInputType.multiline,
                                controller: _noteController,
                              ),
                    
                              SizedBox(height: 16),
                              ActionButtonsRow(
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                onSubmit: _handleAddTask,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
