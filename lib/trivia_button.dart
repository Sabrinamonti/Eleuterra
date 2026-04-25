import 'package:flutter/material.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/primary_button.dart';

class TriviaButton extends StatelessWidget {
  const TriviaButton({
    required this.width,
    required this.height,
    required this.frontColor,
    required this.shadowColor,
    required this.borderColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final double width;
  final double height;
  final Color frontColor;
  final Color shadowColor;
  final Color borderColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GradientShadowButton(
      onTap: onTap,
      width: width,
      height: height,
      frontColor: frontColor,
      shadowColor: shadowColor,
      textColor: AppColors.floralwhite,
      borderColor: borderColor,
      radiusBordertop: 0.06,
      radiusBorderbottom: 0.16,
      heightShadow: 1.08,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.title.copyWith(
                color: AppColors.floralwhite,
              ),
            ),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.placesText.copyWith(
                color: AppColors.floralwhite,
              ),
            ),
          ],
        ),
    );
  }
}