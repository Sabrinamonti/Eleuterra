import 'package:eleuterra_app/theme/app_text.dart';
import 'package:flutter/material.dart';

/// Botón con efecto “capa/sombra” de otro color
class GradientShadowButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color frontColor;
  final Color shadowColor;
  final Color textColor;
  final Color borderColor;
  final double radiusBordertop;
  final double radiusBorderbottom;
  final double heightShadow;

  const GradientShadowButton({
    super.key,
    this.text,
    this.child,
    required this.onTap,
    required this.width,
    required this.height,
    required this.frontColor,
    required this.shadowColor,
    required this.textColor,
    required this.borderColor,
    this.radiusBorderbottom = 0,
    this.radiusBordertop = 0,
    this.heightShadow = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height * heightShadow, // espacio para la “sombra”
      child: Stack(
        alignment: Alignment.center,
        children: [
          // “Sombra” (segunda capa)
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: shadowColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height * radiusBordertop),
                  topRight: Radius.circular(height * radiusBordertop),
                  bottomLeft: Radius.circular(height * radiusBorderbottom),
                  bottomRight: Radius.circular(height * radiusBorderbottom),
                ),
              ),
            ),
          ),

          // Botón principal
          Positioned(
            top: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(height * radiusBorderbottom),
              onTap: onTap,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: frontColor,
                  borderRadius: BorderRadius.circular(height * radiusBorderbottom),
                  border: Border.all(
                    color: borderColor,
                    width: height * 0.11,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.05,
                      horizontal: 12,
                    ),
                    child: child ??
                        Text(
                          text ?? '',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.buttonText.copyWith(
                            color: textColor,
                            fontSize: height * 0.7,
                            height: 1,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


                