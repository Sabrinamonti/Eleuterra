import 'package:eleuterra_app/theme/app_text.dart';
import 'package:flutter/material.dart';

/// Botón con efecto “capa/sombra” de otro color (como en tu imagen)
class GradientShadowButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color frontColor;
  final Color shadowColor;
  final Color textColor;
  final Color borderColor;

  const GradientShadowButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.width,
    required this.height,
    required this.frontColor,
    required this.shadowColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height*1.16, // espacio para la “sombra”
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
                  topLeft: Radius.circular(height*0.45),
                  topRight: Radius.circular(height*0.45),
                  bottomLeft: Radius.circular(height*0.76),
                  bottomRight: Radius.circular(height*0.76),
                ),
              ),
            ),
          ),

          // Botón principal
          Positioned(
            top: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(height*0.76),
              onTap: onTap,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: frontColor,
                  borderRadius: BorderRadius.circular(height*0.76),
                  border: Border.all(
                    color: borderColor,
                    width: height*0.11,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
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