import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    strokeWidth: 4.0,
                  ),
                  if (message != null) 
                  Padding (
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      message!,
                      style: AppTextStyles.descriptionText.copyWith(color: AppColors.white, fontFamily: "sans-serif", decoration: TextDecoration.none)
                    )
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
