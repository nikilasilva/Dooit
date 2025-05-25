import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/custom_input_field.dart';
import 'package:dooit/widgets/custom_password_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text('Doolt !', style: AppTextStyles.logoStyle),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Account',
                      style: AppTextStyles.headingDark,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Sign Up', style: AppTextStyles.subHeading),
                  const SizedBox(height: 16),
                  const CustomInputField(label: 'Username', prefixIcon: Icons.person, keyboardType: TextInputType.text),

                  const SizedBox(height: 16),
                  const CustomInputField(label: 'Email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),

                  const SizedBox(height: 16),
                  const CustomPasswordField(label: 'Password'),

                  const SizedBox(height: 16),
                  const CustomPasswordField(label: 'Confirm Password'),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: AppButtonStyles.primaryButton,
                      child: const Text(
                        'Sign up',
                        style: AppTextStyles.buttonText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already registered? '),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Text('Sign In', style: AppTextStyles.linkStyle),
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
      ),
    );
  }
}
