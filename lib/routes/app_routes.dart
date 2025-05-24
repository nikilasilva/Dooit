import 'package:flutter/material.dart';
import '../ui/onboarding_screen.dart';
import '../ui/signin_screen.dart';
import '../ui/signup_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const OnboardingScreen(),
  '/signin': (context) => const SigninScreen(),
  '/signup': (context) => const SignupScreen(),
};