import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/action_buttons_row.dart';
import 'package:dooit/widgets/profile_option_tile.dart';
import 'package:flutter/material.dart';

class ChangeProfilePictureDialog extends StatelessWidget {
  final VoidCallback onTakePicture;
  final VoidCallback onImportFromGallery;

  const ChangeProfilePictureDialog({
    super.key,
    required this.onTakePicture,
    required this.onImportFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change Profile Picture', style: AppTextStyles.subHeading),
            const SizedBox(height: 10),
            ProfileOptionTile(
              icon: Icons.camera_alt,
              title: "Take picture",
              onTap: onTakePicture,
            ),
            ProfileOptionTile(
              icon: Icons.photo_library,
              title: "Import from gallery",
              onTap: onImportFromGallery,
            ),
            const SizedBox(height: 16),
            ActionButtonsRow(
              onCancel: () {
                Navigator.pop(context);
              },
              onSubmit: () {},
            ),
          ],
        ),
      ),
    );
  }
}
