import 'package:flutter/material.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';

class TriviaButton extends StatefulWidget {
  const TriviaButton({
    super.key,
    required this.width,
    required this.height,
    required this.frontColor,
    required this.shadowColor,
    required this.borderColor,
    required this.title,
    required this.description,
    required this.onTap,
    this.image,
  });

  final double width;
  final double height;
  final Color frontColor;
  final Color shadowColor;
  final Color borderColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  /// Opcional: para poner el gato/ícono a la derecha como en la imagen.
  final Widget? image;

  @override
  State<TriviaButton> createState() => _TriviaButtonState();
}

class _TriviaButtonState extends State<TriviaButton> {
  bool _pressed = false;

  static const double _shadowHeight = 10;
  static const double _borderWidth = 6;
  static const double _radius = 32;

  @override
  Widget build(BuildContext context) {
    final double frontHeight = widget.height - _shadowHeight;

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            /// Sombra inferior gruesa
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: widget.height - 4,
                decoration: BoxDecoration(
                  color: widget.shadowColor,
                  borderRadius: BorderRadius.circular(_radius),
                ),
              ),
            ),

            /// Cuerpo principal
            AnimatedPositioned(
              duration: const Duration(milliseconds: 90),
              curve: Curves.easeOut,
              left: 0,
              right: 0,
              top: _pressed ? _shadowHeight * 0.55 : 0,
              child: Container(
                height: frontHeight,
                decoration: BoxDecoration(
                  color: widget.borderColor,
                  borderRadius: BorderRadius.circular(_radius),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(_borderWidth),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.frontColor,
                      borderRadius: BorderRadius.circular(_radius - 10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 24,
                        top: 1,
                        bottom: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.smallTitle.copyWith(
                                    color: AppColors.floralwhite,
                                    fontSize: 36,
                                    height: 1,
                                    letterSpacing: 0.2,
                                    wordSpacing: -4,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.text.copyWith(
                                    color: AppColors.floralwhite,
                                    fontSize: 14,
                                    height: 1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (widget.image != null) ...[
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 96,
                              height: 86,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: widget.image,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}