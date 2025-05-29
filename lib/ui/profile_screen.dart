import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/change_password_dialog.dart';
import 'package:dooit/widgets/change_profile_picture_dialog.dart';
import 'package:dooit/widgets/custom_confirmation_dialog.dart';
import 'package:dooit/widgets/custom_input_dialog.dart';
import 'package:dooit/widgets/profile_image.dart';
import 'package:dooit/widgets/profile_option_tile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomConfirmationDialog(
          title: "Confirm logout",
          message: "Are you sure you want to logout?",
          onSubmit: () {
            Navigator.pushNamed(context, '/signin');
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
          onSubmit: (value) {},
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ChangePasswordDialog();
      },
    );
  }

  void _showChangeProfilePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ChangeProfilePictureDialog(
          onTakePicture: () {},
          onImportFromGallery: () {},
        );
      },
    );
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
                        imagePath: "assets/images/pro_img.jpg",
                        fallbackText: "Profile Icon",
                        borderColor: AppColors.primary,
                        size: 100.0,
                      ),
                      SizedBox(height: 20),
                      Text("Nathan Jacob", style: AppTextStyles.subHeading),
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
