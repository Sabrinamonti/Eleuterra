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

  const GradientShadowButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.width,
    required this.height,
    required this.frontColor,
    required this.shadowColor,
    required this.textColor,
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
  color: Color(0XFFF37A27),
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
  color: Color(0xffFDB71D),
  borderRadius: BorderRadius.circular(height*0.76),
  border: Border.all(
    color: Color(0xffF9A044),
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

class SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color background;
  final Color textColor;
  final BorderSide? border;

  const SocialButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.background,
    required this.textColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 42,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(22),
            border: border != null ? Border.fromBorderSide(border!) : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}