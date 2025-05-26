import 'package:dooit/widgets/custom_input_field_label.dart';
import 'package:dooit/widgets/custom_password_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_styles.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(child: Text("DooIt !", style: AppTextStyles.logoStyle)),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: Text('Welcome Back', style: AppTextStyles.headingDark),
                ),
                const SizedBox(height: 28),
                Text('Sign In', style: AppTextStyles.subHeading),
                const SizedBox(height: 16),

                const CustomInputFieldLabel(label: 'Email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),

                const SizedBox(height: 16),

                const CustomPasswordField(label: 'Password'),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.linkStyle,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: AppButtonStyles.primaryButton,
                    child: const Text('Sign in', style: AppTextStyles.buttonText),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: Text('Sign Up', style: AppTextStyles.linkStyle),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Center(child: Text("OR")),
                const SizedBox(height: 16),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.google, size: 30),
                    SizedBox(width: 24),
                    Icon(FontAwesomeIcons.facebook, size: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
