import 'package:dooit/ui/add_task_screen.dart';
import 'package:dooit/ui/home_screen.dart';
import 'package:dooit/ui/onboarding_screen.dart';
import 'package:dooit/ui/signin_screen.dart';
import 'package:dooit/ui/signup_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const OnboardingScreen(),
  '/signin': (context) => const SigninScreen(),
  '/signup': (context) => const SignupScreen(),
  '/home': (context) => const HomeScreen(),
  '/add_task': (context) => const AddTaskScreen(),
};