import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String? imagePath;
  final String fallbackText;
  final double size;
  final Color? borderColor;
  final double? borderWidth;

  const ProfileImage({
    super.key,
    this.imagePath,
    this.fallbackText = '',
    this.size = 100.0,
    this.borderColor,
    this.borderWidth = 2.0,
  });

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
        child:
            imagePath != null
                ? Image.asset(
                  imagePath!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
                : Center(
                  child: Text(
                    fallbackText,
                    style: TextStyle(
                      fontSize: size * 0.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
      ),
    );
  }
}
