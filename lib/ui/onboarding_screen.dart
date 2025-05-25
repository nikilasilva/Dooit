import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/app_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFD9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text('Doolt!', style: AppTextStyles.logoStyle),
              const SizedBox(height: 20),
              Expanded(
                flex: 3,
                child: Lottie.asset(
                  'assets/lotties/onboard_animation.json',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Stay Organized, Stay Productive – Your Tasks, Your Way!',
                textAlign: TextAlign.center,
                style: AppTextStyles.subHeadingDark,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                style: AppButtonStyles.primaryButton,
                child: const Text(
                  'Get Started',
                  style: AppTextStyles.buttonText,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
