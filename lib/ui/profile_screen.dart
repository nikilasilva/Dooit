import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/profile_image.dart';
import 'package:dooit/widgets/profile_option_tile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 4),
      body: SafeArea(
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
                    onTap: () {},
                  ),
                  ProfileOptionTile(
                    icon: Icons.password,
                    title: "Change password",
                    onTap: () {},
                  ),
                  ProfileOptionTile(
                    icon: Icons.image,
                    title: "Change profile picture",
                    onTap: () {},
                  ),
                  ProfileOptionTile(
                    icon: Icons.logout,
                    title: "Log out",
                    iconColor: AppColors.red,
                    textColor: AppColors.red,
                    isBold: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
