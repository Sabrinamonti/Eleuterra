import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final double width;
  final double height;
  final Color frontColor;
  final Color shadowColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double shadowOffset;
  final VoidCallback? onTap;
  final Widget? child;

  const BigButton({
    super.key,
    this.width = 390,
    this.height = 130,
    this.frontColor = const Color(0xFF282224),
    this.shadowColor = const Color(0xFFF37927),
    this.borderColor = const Color(0xFFF9A044),
    this.borderWidth = 5.5,
    this.borderRadius = 28,
    this.shadowOffset = 14,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final outerRadius = BorderRadius.circular(borderRadius);
    final innerRadius = BorderRadius.circular(
      (borderRadius - borderWidth).clamp(0.0, borderRadius).toDouble(),
    );

    return SizedBox(
      width: width,
      height: height + shadowOffset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: shadowOffset,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: shadowColor,
                borderRadius: outerRadius,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Material(
              color: Colors.transparent,
              borderRadius: outerRadius,
              child: InkWell(
                onTap: onTap,
                borderRadius: outerRadius,
                child: Container(
                  width: width,
                  height: height,
                  padding: EdgeInsets.all(borderWidth),
                  decoration: BoxDecoration(
                    color: frontColor,
                    borderRadius: outerRadius,
                    border: Border.all(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: innerRadius,
                    child: child ?? const SizedBox.expand(),
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