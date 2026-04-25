import 'package:eleuterra_app/home_screen_no_trip.dart';
import 'package:eleuterra_app/trivia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/home_screen_trip.dart';
import 'package:eleuterra_app/trivia.dart';
import 'package:eleuterra_app/world_main.dart';
import 'package:eleuterra_app/profile.dart';
import 'package:eleuterra_app/news.dart';


enum MainMenuItem {
  home,
  trivia,
  world,
  profile,
  news,
  more,
}

enum HomeDestination {
  trip,
  noTrip,
  mapOpen,
}

class MainMenu extends StatelessWidget {
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

  static const double _topBarHeight = 5;
  static const double _menuHorizontalPadding = 22;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildMainBar(context),
          if (currentItem == MainMenuItem.more)
            _OptionsOverlay(
              width: width,
              height: height,
              onDismiss: () => Navigator.of(context).pop(),
              onProgramTripTap: () {
                Navigator.of(context).pop();
                // TODO: reemplaza por tu ruta real.
              },
              onAtlasTap: () {
                Navigator.of(context).pop();
                // TODO: reemplaza por tu ruta real.
              },
              onSettingsTap: () {
                Navigator.of(context).pop();
                // TODO: reemplaza por tu ruta real.
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMainBar(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
                    iconPath: 'assets/menu_icons/home.svg',
                    isSelected: currentItem == MainMenuItem.home,
                    onTap: () => _goToHome(context),
                  ),
                  _MenuButton(
                    iconPath: 'assets/menu_icons/trivia.svg',
                    isSelected: currentItem == MainMenuItem.trivia,
                    onTap: () => _pushReplacement(context, const TriviaOptions()),
                  ),
                  _MenuButton(
                    iconPath: 'assets/menu_icons/world.svg',
                    isSelected: currentItem == MainMenuItem.world,
                    onTap: () => _pushReplacement(context, const World()),
                  ),
                  _MenuButton(
                    iconPath: 'assets/menu_icons/profile.svg',
                    isSelected: currentItem == MainMenuItem.profile,
                    onTap: () => _pushReplacement(context, const Profile()),
                  ),
                  _MenuButton(
                    iconPath: 'assets/menu_icons/news.svg',
                    isSelected: currentItem == MainMenuItem.news,
                    onTap: () => _pushReplacement(context, const News()),
                  ),
                  _MenuButton(
                    iconPath: 'assets/menu_icons/more.svg',
                    isSelected: currentItem == MainMenuItem.more,
                    onTap: () => _openOptionsOverlay(context),
                    iconSize: 9,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToHome(BuildContext context) {
    switch (homeDestination) {
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

  void _openOptionsOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'Options overlay',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, __, ___) {
        return SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: MainMenu(
                currentItem: MainMenuItem.more,
                homeDestination: homeDestination,
                width: 440,
                height: 100,
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
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
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
    this.iconSize = 32,
  });

  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;
  final double iconSize;

  static const double _circleSize = 58;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: _circleSize,
        height: _circleSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: _circleSize,
              height: _circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.floralwhite
                    : Colors.transparent,
              ),
            ),
            SvgPicture.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionsOverlay extends StatelessWidget {
  const _OptionsOverlay({
    required this.width,
    required this.height,
    required this.onDismiss,
    required this.onProgramTripTap,
    required this.onAtlasTap,
    required this.onSettingsTap,
  });

  final double width;
  final double height;
  final VoidCallback onDismiss;
  final VoidCallback onProgramTripTap;
  final VoidCallback onAtlasTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: height,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width,
          decoration: const BoxDecoration(
            color: AppColors.espressobrown,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _OverlayOption(
                iconPath: 'assets/icons/add_trip.svg',
                label: 'Program or Add a Trip',
                onTap: onProgramTripTap,
              ),
              Container(
                height: 1,
                color: AppColors.earthybrown,
              ),
              _OverlayOption(
                iconPath: 'assets/icons/atlas_plus.svg',
                label: 'Atlas+',
                onTap: onAtlasTap,
              ),
              Container(
                height: 1,
                color: AppColors.earthybrown,
              ),
              _OverlayOption(
                iconPath: 'assets/icons/settings.svg',
                label: 'Settings',
                onTap: onSettingsTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverlayOption extends StatelessWidget {
  const _OverlayOption({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 74,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.floralwhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
