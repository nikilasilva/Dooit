import 'dart:io';

import 'package:change_case/change_case.dart';
import 'package:dooit/providers/auth_provider.dart';
import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/utils/snackbar_helper.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/change_password_dialog.dart';
import 'package:dooit/widgets/change_profile_picture_dialog.dart';
import 'package:dooit/widgets/custom_confirmation_dialog.dart';
import 'package:dooit/widgets/custom_input_dialog.dart';
import 'package:dooit/widgets/profile_image.dart';
import 'package:dooit/widgets/profile_option_tile.dart';
import 'package:dooit/widgets/skeleton_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String? _photoUrl;
  File? _imagePreviewFile;
  bool _isLoading = true;

  Future<void> _loadUserData() async {
    // Use a post-frame callbackto avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        final displayName = authProvider.user!.displayName;
        final email = authProvider.user!.email;

        setState(() {
          // If display name exists, use it; otherwise use the first part of email
          String rawName =
              displayName != null && displayName.isNotEmpty
                  ? displayName
                  : email != null
                  ? email.split('@')[0]
                  : 'User';
          _username = rawName.toTitleCase();
          _photoUrl = authProvider.user!.photoURL;
          _isLoading = false;
        });
      } else {
        setState(() {
          _username = "User";
          _isLoading = false;
        });
      }
    });
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomConfirmationDialog(
          title: "Confirm logout",
          message: "Are you sure you want to logout?",
          onSubmit: () async {
            final authProvider = Provider.of<AuthProvider>(
              context,
              listen: false,
            );
            await authProvider.signOut();

            if (!mounted) return;

            // Clear the navigation stack and go to the sign-in screen
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/signin', (route) => false);
          },
        );
      },
    );
  }

  void _showChangeUsernameDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return CustomInputDialog(
          title: "Change username",
          hintText: "New username",
          onSubmit: (value) async {
            if (value.trim().isEmpty) {
              SnackbarHelper.showErrorSnackBar(
                context,
                "Username cannot be empty.",
              );
              return;
            }

            final authProvider = Provider.of<AuthProvider>(
              context,
              listen: false,
            );
            final success = await authProvider.updateUsername(value);

            if (!mounted) return;

            if (success) {
              // Update the local state to reflect the change immediately
              setState(() {
                _username = value.toTitleCase();
              });
              SnackbarHelper.showSuccessSnackBar(
                context,
                "Username updated successfully!",
              );
            } else {
              SnackbarHelper.showErrorSnackBar(
                context,
                authProvider.errorMessage ?? "Failed to update username.",
              );
            }
          },
        );
      },
    );
  }

  void _showChangePasswordDialog() async {
    // Await the result from the dialog. It will be 'true' on success.
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return const ChangePasswordDialog();
      },
    );

    // If the result is true, it means the password was changed successfully.
    if (result == true) {
      if (!mounted) return;
      // Show the success message using the ProfileScreen's context.
      SnackbarHelper.showSuccessSnackBar(
        context,
        "Password changed successfully!",
      );
    }
  }

  void _showChangeProfilePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ChangeProfilePictureDialog(
          onTakePicture: () {
            Navigator.pop(dialogContext);
            _pickImage(ImageSource.camera);
          },
          onImportFromGallery: () {
            Navigator.pop(dialogContext);
            _pickImage(ImageSource.gallery);
          },
        );
      },
    );
  }

  // Handle image picking and uploading
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      final imageFile = File(image.path);
      setState(() {
        _imagePreviewFile = imageFile;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.updateProfilePicture(imageFile);

      if (!mounted) return;

      if (success) {
        setState(() {
          _imagePreviewFile = null;
          _photoUrl = authProvider.user?.photoURL;
        });
        SnackbarHelper.showSuccessSnackBar(
          context,
          "Profile picture updated successfully!",
        );
      } else {
        setState(() {
          _imagePreviewFile = null;
        });
        SnackbarHelper.showErrorSnackBar(context, authProvider.errorMessage ?? "Failed to update profile picture.");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.background,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Text("Profile", style: AppTextStyles.heading),
                      SizedBox(height: 20),
                      ProfileImage(
                        assetPath: "assets/images/default_profile.png",
                        localFile: _imagePreviewFile,
                        networkUrl: _photoUrl,
                        fallbackText: _username.isNotEmpty ? _username : "Profile Icon",
                        borderColor: AppColors.primary,
                        size: 100.0,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child:
                            _isLoading
                                ? const SkeletonText(width: 200, height: 22)
                                : Text(
                                  _username,
                                  style: AppTextStyles.heading.copyWith(
                                    fontSize: 30,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Account", style: AppTextStyles.subHeading2),
                    ),
                    SizedBox(height: 16),
                    ProfileOptionTile(
                      icon: Icons.edit,
                      title: "Change username",
                      onTap: () {
                        _showChangeUsernameDialog();
                      },
                    ),
                    ProfileOptionTile(
                      icon: Icons.password,
                      title: "Change password",
                      onTap: () {
                        _showChangePasswordDialog();
                      },
                    ),
                    ProfileOptionTile(
                      icon: Icons.image,
                      title: "Change profile picture",
                      onTap: () {
                        _showChangeProfilePictureDialog();
                      },
                    ),
                    ProfileOptionTile(
                      icon: Icons.logout,
                      title: "Log out",
                      iconColor: AppColors.red,
                      textColor: AppColors.red,
                      isBold: true,
                      onTap: () {
                        _showLogoutConfirmationDialog();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
