import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:eleuterra_app/primary_button.dart';  

class PrimaryButtonNoreturn extends StatelessWidget {
  final Widget destination;
  final String text;

  const PrimaryButtonNoreturn({
    super.key,
    required this.destination,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GradientShadowButton(
      text: text,
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 550),
            reverseTransitionDuration: const Duration(milliseconds: 450),
            pageBuilder: (context, animation, secondaryAnimation) =>
                destination,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
                reverseCurve: Curves.easeInCubic,
              );

              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(curved),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.04),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
          (route) => false,
        );
      },
      width: 200,
      height: 44,
      frontColor: AppColors.mustardyellow,
      shadowColor: AppColors.vividtangelo,
      textColor: AppColors.floralwhite,
      borderColor: AppColors.royalorange,
      radiusBordertop: 0.45,
      radiusBorderbottom: 0.76,
      heightShadow: 1.16,
    );
  }
}