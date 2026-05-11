import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:eleuterra_app/home_screen_no_trip.dart';
import 'package:eleuterra_app/home_screen_trip.dart';
import 'package:eleuterra_app/news.dart';
import 'package:eleuterra_app/profile.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/trivia.dart';
import 'package:eleuterra_app/world_main.dart';

enum MainMenuItem { home, trivia, world, profile, news, more }

enum HomeDestination { trip, noTrip, mapOpen }

class MainMenu extends StatefulWidget {
  const MainMenu({
    super.key,
    required this.currentItem,
    required this.homeDestination,
    this.height = 100,
    this.width = double.infinity,
  });

  final MainMenuItem currentItem;
  final HomeDestination homeDestination;
  final double height;
  final double width;

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  static const double _topBarHeight = 5;
  static const double _menuHorizontalPadding = 22;

  static const Duration _gentleDuration = Duration(milliseconds: 280);
  static const Curve _gentleCurve = Curves.easeInOutCubic;

  late MainMenuItem _selectedItem;
  bool _isMoreOverlayOpen = false;

  bool get _usesLongMoreOverlay => widget.currentItem == MainMenuItem.world;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.currentItem;
  }

  @override
  void didUpdateWidget(covariant MainMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_isMoreOverlayOpen) {
      _selectedItem = widget.currentItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.espressobrown,
      child: Column(
        children: [
          Container(
            height: _topBarHeight,
            width: double.infinity,
            color: AppColors.midnightgrey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _menuHorizontalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MenuButton(
                    selectedIconPath: 'assets/menu_icons/home.svg',
                    unselectedIconPath: 'assets/menu_icons/home-white.svg',
                    isSelected: _selectedItem == MainMenuItem.home,
                    onTap: () => _goToHome(context),
                    duration: _gentleDuration,
                    curve: _gentleCurve,
                  ),
                  _MenuButton(
                    selectedIconPath: 'assets/menu_icons/trivia.svg',
                    unselectedIconPath: 'assets/menu_icons/trivia-white.svg',
                    isSelected: _selectedItem == MainMenuItem.trivia,
                    iconSize: 60,
                    onTap: () => _goToPage(
                      context,
                      MainMenuItem.trivia,
                      const TriviaOptions(),
                    ),
                    duration: _gentleDuration,
                    curve: _gentleCurve,
                  ),
                  _MenuButton(
                    selectedIconPath: 'assets/menu_icons/world.svg',
                    unselectedIconPath: 'assets/menu_icons/world-white.svg',
                    isSelected: _selectedItem == MainMenuItem.world,
                    onTap: () =>
                        _goToPage(context, MainMenuItem.world, const World()),
                    duration: _gentleDuration,
                    curve: _gentleCurve,
                  ),
                  _MenuButton(
                    selectedIconPath: 'assets/menu_icons/profile.svg',
                    unselectedIconPath: 'assets/menu_icons/profile-white.svg',
                    isSelected: _selectedItem == MainMenuItem.profile,
                    onTap: () => _goToPage(
                      context,
                      MainMenuItem.profile,
                      const Profile(),
                    ),
                    duration: _gentleDuration,
                    curve: _gentleCurve,
                  ),
                  _MenuButton(
                    selectedIconPath: 'assets/menu_icons/notifications.svg',
                    unselectedIconPath:
                        'assets/menu_icons/notifications-white.svg',
                    isSelected: _selectedItem == MainMenuItem.news,
                    onTap: () =>
                        _goToPage(context, MainMenuItem.news, const News()),
                    duration: _gentleDuration,
                    curve: _gentleCurve,
                  ),
                  _MenuButton(
                    selectedIconPath: 'assets/menu_icons/more.svg',
                    unselectedIconPath: 'assets/menu_icons/more-white.svg',
                    isSelected: _selectedItem == MainMenuItem.more,
                    onTap: () => _openOptionsOverlay(context),
                    iconSize: 8,
                    duration: _gentleDuration,
                    curve: _gentleCurve,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToHome(BuildContext context) async {
    setState(() {
      _selectedItem = MainMenuItem.home;
    });

    await Future.delayed(_gentleDuration);

    if (!context.mounted) return;

    switch (widget.homeDestination) {
      case HomeDestination.trip:
        _pushReplacement(context, const HomeScreenTrip());
        break;
      case HomeDestination.noTrip:
        _pushReplacement(context, const HomeScreenNoTrip());
        break;
      case HomeDestination.mapOpen:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
    }
  }

  Future<void> _goToPage(
    BuildContext context,
    MainMenuItem item,
    Widget page,
  ) async {
    setState(() {
      _selectedItem = item;
    });

    await Future.delayed(_gentleDuration);

    if (!context.mounted) return;

    _pushReplacement(context, page);
  }

  void _openOptionsOverlay(BuildContext context) {
    if (_isMoreOverlayOpen) return;

    setState(() {
      _isMoreOverlayOpen = true;
      _selectedItem = MainMenuItem.more;
    });

    showGeneralDialog(
      context: context,
      barrierLabel: 'Main menu options',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: _gentleDuration,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: widget.height),
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width,
                  maxHeight: MediaQuery.sizeOf(context).height - widget.height,
                ),
                child: _usesLongMoreOverlay
                    ? _LongMoreOverlay(
                        onWorldTap: () {
                          Navigator.of(context).pop();
                          _goToPage(context, MainMenuItem.world, const World());
                        },
                        onPlacesTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Places
                        },
                        onRoutesTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Routes
                        },
                        onPhotosTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Photos
                        },
                        onProgramTripTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Program or Add a Trip
                        },
                        onAtlasTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Atlas+
                        },
                        onSettingsTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Settings
                        },
                      )
                    : _ShortMoreOverlay(
                        onProgramTripTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Program or Add a Trip
                        },
                        onAtlasTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Atlas+
                        },
                        onSettingsTap: () {
                          Navigator.of(context).pop();
                          // TODO: navegar a Settings
                        },
                      ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: _gentleCurve,
          reverseCurve: _gentleCurve,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    ).whenComplete(() {
      if (!mounted) return;

      setState(() {
        _isMoreOverlayOpen = false;
        _selectedItem = widget.currentItem;
      });
    });
  }

  void _pushReplacement(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.selectedIconPath,
    required this.unselectedIconPath,
    required this.isSelected,
    required this.onTap,
    required this.duration,
    required this.curve,
    this.iconSize = 34,
  });

  final String selectedIconPath;
  final String unselectedIconPath;
  final bool isSelected;
  final VoidCallback onTap;
  final Duration duration;
  final Curve curve;
  final double iconSize;

  static const double _tapSize = 58;
  static const double _circleSize = 58;

  @override
  Widget build(BuildContext context) {
    final String iconPath = isSelected ? selectedIconPath : unselectedIconPath;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: _tapSize,
        height: _tapSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedScale(
              duration: duration,
              curve: curve,
              scale: isSelected ? 1 : 0.15,
              child: AnimatedContainer(
                duration: duration,
                curve: curve,
                width: _circleSize,
                height: _circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.floralwhite
                      : Colors.transparent,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: duration,
              switchInCurve: curve,
              switchOutCurve: curve,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.88,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: SvgPicture.asset(
                iconPath,
                key: ValueKey<String>(iconPath),
                width: iconSize,
                height: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShortMoreOverlay extends StatelessWidget {
  const _ShortMoreOverlay({
    required this.onProgramTripTap,
    required this.onAtlasTap,
    required this.onSettingsTap,
  });

  final VoidCallback onProgramTripTap;
  final VoidCallback onAtlasTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return _MoreOverlayContainer(
      children: [
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/plus.svg',
          label: 'Program or Add a Trip',
          iconWidth: 22,
          iconHeight: 22,
          onTap: onProgramTripTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/icons/atlas_logo.svg',
          label: 'Atlas+',
          iconWidth: 50,
          onTap: onAtlasTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/settings.svg',
          label: 'Settings',
          iconWidth: 22,
          iconHeight: 22,
          onTap: onSettingsTap,
        ),
      ],
    );
  }
}

class _LongMoreOverlay extends StatelessWidget {
  const _LongMoreOverlay({
    required this.onWorldTap,
    required this.onPlacesTap,
    required this.onRoutesTap,
    required this.onPhotosTap,
    required this.onProgramTripTap,
    required this.onAtlasTap,
    required this.onSettingsTap,
  });

  final VoidCallback onWorldTap;
  final VoidCallback onPlacesTap;
  final VoidCallback onRoutesTap;
  final VoidCallback onPhotosTap;
  final VoidCallback onProgramTripTap;
  final VoidCallback onAtlasTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return _MoreOverlayContainer(
      children: [
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/world.svg',
          label: 'World',
          iconWidth: 24,
          iconHeight: 24,
          onTap: onWorldTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/places.svg',
          label: 'Places',
          iconWidth: 24,
          iconHeight: 24,
          onTap: onPlacesTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/routes.svg',
          label: 'Routes',
          iconWidth: 24,
          iconHeight: 24,
          onTap: onRoutesTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/photos.svg',
          label: 'Photos',
          iconWidth: 24,
          iconHeight: 24,
          onTap: onPhotosTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/plus.svg',
          label: 'Program or Add a Trip',
          iconWidth: 22,
          iconHeight: 22,
          onTap: onProgramTripTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/icons/atlas_logo.svg',
          label: 'Atlas+',
          iconWidth: 42,
          iconHeight: 16,
          onTap: onAtlasTap,
        ),
        const _MoreOverlayDivider(),
        _MoreOverlayOption(
          iconPath: 'assets/menu_icons/settings.svg',
          label: 'Settings',
          iconWidth: 24,
          iconHeight: 24,
          onTap: onSettingsTap,
        ),
      ],
    );
  }
}

class _MoreOverlayContainer extends StatelessWidget {
  const _MoreOverlayContainer({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: AppColors.espressobrown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _MoreOverlayDivider(),
          ...children,
        ],
      ),
    );
  }
}

class _MoreOverlayOption extends StatelessWidget {
  const _MoreOverlayOption({
    required this.iconPath,
    required this.label,
    required this.onTap,
    this.iconWidth = 24,
    this.iconHeight = 24,
    this.iconBoxWidth = 46,
    this.optionHeight = 40,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  /// Aquí modificas el ancho del ícono individualmente.
  final double iconWidth;

  /// Aquí modificas el alto del ícono individualmente.
  final double iconHeight;

  /// Espacio reservado para el ícono antes del texto.
  final double iconBoxWidth;

  /// Alto de cada opción del overlay.
  final double optionHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.earthybrown.withOpacity(0.25),
      highlightColor: AppColors.earthybrown.withOpacity(0.18),
      child: SizedBox(
        height: optionHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              SizedBox(
                width: iconBoxWidth,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    iconPath,
                    width: iconWidth,
                    height: iconHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.infoText.copyWith(
                    color: AppColors.floralwhite,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreOverlayDivider extends StatelessWidget {
  const _MoreOverlayDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.5,
      width: double.infinity,
      color: AppColors.earthybrown,
    );
  }
}