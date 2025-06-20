import 'package:dooit/providers/auth_provider.dart';
import 'package:dooit/services/auth_service.dart';
import 'package:dooit/utils/snackbar_helper.dart';
import 'package:dooit/widgets/custom_input_field_label.dart';
import 'package:dooit/widgets/custom_password_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_styles.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Test Firebase connection
      final authService = AuthService();
      bool isConnected = await authService.testFirebaseConnection();

      if (!isConnected) {
        if (!mounted) return;
        SnackbarHelper.showErrorSnackBar(context, "Cannot connect to Firebase. Please check your internet connection");
        return;
      }

      bool success = await authProvider.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        final errorMsg = authProvider.errorMessage ?? 'Sign in failed';
        if (errorMsg.contains('password')) {
          // Password-specific error
          SnackbarHelper.showErrorSnackBar(context, errorMsg);
        } else {
          // Other errors
          SnackbarHelper.showErrorSnackBar(context, errorMsg);
        }
      }
    }
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text("DooIt !", style: AppTextStyles.logoStyle),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome Back',
                      style: AppTextStyles.headingDark,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Sign In', style: AppTextStyles.subHeading),
                  const SizedBox(height: 16),

                  CustomInputFieldLabel(
                    label: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  CustomPasswordField(
                    label: 'Password',
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.linkStyle,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              authProvider.isLoading ? null : _handleSignIn,
                          style: AppButtonStyles.primaryButton,
                          child:
                              authProvider.isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'Sign in',
                                    style: AppTextStyles.buttonText,
                                  ),
                        ),
                      );
                    },
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
      ),
    );
  }
}
