import 'package:DooIt/ui/add_task_screen.dart';
import 'package:DooIt/ui/all_tasks_screen.dart';
import 'package:DooIt/ui/calendar_screen.dart';
import 'package:DooIt/ui/categories_screen.dart';
import 'package:DooIt/ui/home_screen.dart';
import 'package:DooIt/ui/onboarding_screen.dart';
import 'package:DooIt/ui/previous_tasks_screen.dart';
import 'package:DooIt/ui/profile_screen.dart';
import 'package:DooIt/ui/progress_screen.dart';
import 'package:DooIt/ui/signin_screen.dart';
import 'package:DooIt/ui/signup_screen.dart';
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
  '/profile': (context) => const ProfileScreen(),
  '/progress': (context) => const ProgressScreen(),
  '/calendar': (context) => const CalendarScreen(),
};