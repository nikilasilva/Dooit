import 'package:dooit/ui/add_task_screen.dart';
import 'package:dooit/ui/all_tasks_screen.dart';
import 'package:dooit/ui/categories_screen.dart';
import 'package:dooit/ui/home_screen.dart';
import 'package:dooit/ui/onboarding_screen.dart';
import 'package:dooit/ui/previous_tasks_screen.dart';
import 'package:dooit/ui/signin_screen.dart';
import 'package:dooit/ui/signup_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const OnboardingScreen(),
  '/signin': (context) => const SigninScreen(),
  '/signup': (context) => const SignupScreen(),
  '/home': (context) => const HomeScreen(),
  '/add_task': (context) => const AddTaskScreen(),
  '/categories': (context) => const CategoriesScreen(),
  '/all_tasks': (context) => const AllTasksScreen(),
  '/previous_tasks': (context) => const PreviousTasksScreen(),
};