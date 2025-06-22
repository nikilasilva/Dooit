import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? assetPath;
  final String? networkUrl;
  final File? localFile;
  final String fallbackText;
  final double size;
  final Color? borderColor;
  final double? borderWidth;

  const ProfileImage({
    super.key,
    this.assetPath,
    this.networkUrl,
    this.localFile,
    this.fallbackText = '',
    this.size = 100.0,
    this.borderColor,
    this.borderWidth = 2.0,
  });

  Widget _buildImage() {
    if (localFile != null) {
      // Show local file if it exists
      return Image.file(
        localFile!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    } else if (networkUrl != null && networkUrl!.isNotEmpty) {
      // Show network image if URL is available
      return Image.network(
        networkUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          // Fallback to asset image on error
          return _buildAssetImage();
        },
      );
    } else {
      return _buildAssetImage();
    }
  }

  Widget _buildAssetImage() {
    return Image.asset(
      assetPath ??  'assets/images/default_profile.png',
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // If the asset also fails, show fallback text
        return Center(
          child: Text(
            fallbackText,
            style: TextStyle(fontSize: size * 0.3, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration:
          borderColor != null
              ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor!, width: borderWidth ?? 2.0),
              )
              : null,
      child: ClipOval(
        child: _buildImage()
      ),
    );
  }
}
