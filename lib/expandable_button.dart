import 'package:flutter/material.dart';
import 'package:eleuterra_app/theme/app_text.dart';

class ExpandableItem {
  final String label;
  final Widget trailing;

  const ExpandableItem({required this.label, required this.trailing});
}

class ExpandableButton extends StatefulWidget {
  final String title;
  final List<ExpandableItem> items;

  final double closedWidth;
  final double closedHeight;

  final double openWidth;
  final double openHeight;

  final Color frontColor;
  final Color shadowColor;
  final Color textColor;
  final Color borderColor;

  final EdgeInsets openContentPadding;

  const ExpandableButton({
    super.key,
    required this.title,
    required this.items,
    required this.closedWidth,
    required this.closedHeight,
    required this.openWidth,
    required this.openHeight,
    required this.frontColor,
    required this.shadowColor,
    required this.textColor,
    required this.borderColor,
    this.openContentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 12,
    ),
  });

  @override
  State<ExpandableButton> createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;

  static const Duration _duration = Duration(milliseconds: 800);
  static const Curve _curve = Curves.easeInOutCubic;

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  BorderRadius _closedShadowRadius(double height) {
    return BorderRadius.only(
      topLeft: Radius.circular(height * 0.45),
      topRight: Radius.circular(height * 0.45),
      bottomLeft: Radius.circular(height * 0.76),
      bottomRight: Radius.circular(height * 0.76),
    );
  }

  BorderRadius _closedFrontRadius(double height) {
    return BorderRadius.circular(height * 0.76);
  }

  BorderRadius _openRadius(double height) {
    return BorderRadius.circular(height * 0.16);
  }

  @override
  Widget build(BuildContext context) {
    final width = _isOpen ? widget.openWidth : widget.closedWidth;
    final height = _isOpen ? widget.openHeight : widget.closedHeight;

    final frontRadius = _isOpen
        ? _openRadius(height)
        : _closedFrontRadius(widget.closedHeight);

    final shadowRadius = _isOpen
        ? _openRadius(height)
        : _closedShadowRadius(widget.closedHeight);

    final borderWidth = widget.closedHeight * 0.11;

    final currentFrontColor = _isOpen
        ? const Color(0xFF282224)
        : widget.frontColor;

    return AnimatedContainer(
      duration: _duration,
      curve: _curve,
      width: width,
      height: _isOpen ? (height * 1.16) + 34 : height * 1.16,
      alignment: Alignment.topLeft,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: _isOpen ? 44 : (height * 1.16 - height),
            child: AnimatedContainer(
              duration: _duration,
              curve: _curve,
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: widget.shadowColor,
                borderRadius: shadowRadius,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: _isOpen ? 34 : 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: frontRadius,
                onTap: _toggle,
                child: AnimatedContainer(
                  duration: _duration,
                  curve: _curve,
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: currentFrontColor,
                    borderRadius: frontRadius,
                    border: Border.all(
                      color: widget.borderColor,
                      width: borderWidth,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: frontRadius,
                    child: AnimatedSwitcher(
                      duration: _duration,
                      switchInCurve: _curve,
                      switchOutCurve: _curve,
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      transitionBuilder: (child, animation) {
                        final fade = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        );

                        final slide = Tween<Offset>(
                          begin: const Offset(0.04, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(parent: animation, curve: _curve),
                        );

                        return FadeTransition(
                          opacity: fade,
                          child: SlideTransition(position: slide, child: child),
                        );
                      },
                      child: _isOpen
                          ? _OpenContent(
                              key: const ValueKey('open'),
                              items: widget.items,
                              textColor: widget.textColor,
                              padding: widget.openContentPadding,
                            )
                          : _ClosedContent(
                              key: const ValueKey('closed'),
                              title: widget.title,
                              textColor: widget.textColor,
                              height: widget.closedHeight,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isOpen)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.buttonText.copyWith(
                      color: widget.frontColor,
                      fontSize: 24,
                      height: 1,
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

class _ClosedContent extends StatelessWidget {
  final String title;
  final Color textColor;
  final double height;

  const _ClosedContent({
    super.key,
    required this.title,
    required this.textColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.05, horizontal: 12),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.buttonText.copyWith(
            color: textColor,
            fontSize: height * 0.7,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _OpenContent extends StatelessWidget {
  final List<ExpandableItem> items;
  final Color textColor;
  final EdgeInsets padding;

  const _OpenContent({
    super.key,
    required this.items,
    required this.textColor,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final itemStyle = AppTextStyles.buttonText.copyWith(
      color: textColor,
      fontSize: 16,
      height: 1.1,
    );

    return Padding(
      padding: padding,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 6),
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        itemBuilder: (context, index) {
          final item = items[index];

          return Row(
            children: [
              Expanded(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  style: itemStyle,
                ),
              ),
              const SizedBox(width: 10),
              item.trailing,
            ],
          );
        },
      ),
    );
  }
}