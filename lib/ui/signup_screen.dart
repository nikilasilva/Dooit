import 'package:DooIt/providers/auth_provider.dart';
import 'package:DooIt/services/auth_service.dart';
import 'package:DooIt/utils/app_styles.dart';
import 'package:DooIt/widgets/custom_input_field_label.dart';
import 'package:DooIt/widgets/custom_password_field.dart';
import 'package:DooIt/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Test Firebase connection first
      final authService = AuthService();
      bool isConnected = await authService.testFirebaseConnection();

      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Cannot connect to Firebase. Please check your internet connection.",
            ),
          ),
        );
        return;
      }

      bool success = await authProvider.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        _usernameController.text.trim(),
      );

      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Sign up failed'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return LoadingOverlay(
          isLoading: authProvider.isLoading,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Center(
                            child: Text(
                              'Doolt !',
                              style: AppTextStyles.logoStyle,
                            ),
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
                          CustomInputFieldLabel(
                            label: 'Username',
                            prefixIcon: Icons.person,
                            keyboardType: TextInputType.text,
                            controller: _usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),
                          CustomInputFieldLabel(
                            label: 'Email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
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
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),
                          CustomPasswordField(
                            label: 'Confirm Password',
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      authProvider.isLoading
                                          ? null
                                          : _handleSignUp,
                                  style: AppButtonStyles.primaryButton,
                                  child: Text(
                                    'Sign up',
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
                              const Text('Already registered? '),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/signin',
                                  );
                                },
                                child: Text(
                                  'Sign In',
                                  style: AppTextStyles.linkStyle,
                                ),
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
            ),
          ),
        );
      },
    );
  }
}
