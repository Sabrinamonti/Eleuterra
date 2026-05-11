import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusButtons extends StatelessWidget {
  final VoidCallback onCityTap;
  final VoidCallback? onAtlasTap;
  final VoidCallback? onCoinsTap;

  final String city;
  final int coins;

  final String flagAsset;
  final String atlasAsset;
  final String coinAsset;

  final Color textColor;
  final double height;

  const StatusButtons({
    super.key,
    required this.onCityTap,
    this.onAtlasTap,
    this.onCoinsTap,
    this.city = 'Istanbul, Türkiye',
    this.coins = 250,
    this.flagAsset = 'assets/flags/turkiye.svg',
    this.atlasAsset = 'assets/icons/atlas_logo.svg',
    this.coinAsset = 'assets/icons/coin.svg',
    this.textColor = AppColors.floralwhite,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    const double locationWidth = 130;
    const double atlasWidth = 62;
    const double coinWidth = 56;
    const double gap = 10;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: TopLocationButton(
              width: locationWidth,
              height: height,
              city: city,
              flagAsset: flagAsset,
              textColor: textColor,
              onTap: onCityTap,
            ),
          ),

          Positioned(
            right: coinWidth + gap,
            top: 0,
            bottom: 0,
            child: TopAtlasButton(
              width: atlasWidth,
              height: height,
              atlasAsset: atlasAsset,
              onTap: onAtlasTap,
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: TopCoinButton(
              width: coinWidth,
              height: height,
              coinAsset: coinAsset,
              coins: coins,
              textColor: textColor,
              onTap: onCoinsTap,
            ),
          ),
        ],
      ),
    );
  }
}

class TopLocationButton extends StatelessWidget {
  final double width;
  final double height;
  final String city;
  final String flagAsset;
  final Color textColor;
  final VoidCallback? onTap;

  const TopLocationButton({
    super.key,
    required this.width,
    required this.height,
    required this.city,
    required this.flagAsset,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _BorderlessTapArea(
      width: width,
      height: height,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            flagAsset,
            width: 22,
            height: 14,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              city,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.placesTextSmall.copyWith(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopAtlasButton extends StatelessWidget {
  final double width;
  final double height;
  final String atlasAsset;
  final VoidCallback? onTap;

  const TopAtlasButton({
    super.key,
    required this.width,
    required this.height,
    required this.atlasAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _BorderlessTapArea(
      width: width,
      height: height,
      onTap: onTap,
      child: Center(
        child: SvgPicture.asset(
          atlasAsset,
          height: 15,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class TopCoinButton extends StatelessWidget {
  final double width;
  final double height;
  final String coinAsset;
  final int coins;
  final Color textColor;
  final VoidCallback? onTap;

  const TopCoinButton({
    super.key,
    required this.width,
    required this.height,
    required this.coinAsset,
    required this.coins,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _BorderlessTapArea(
      width: width,
      height: height,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            coinAsset,
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 5),
          Text(
            '$coins',
            style: AppTextStyles.placesTextSmall.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BorderlessTapArea extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final VoidCallback? onTap;

  const _BorderlessTapArea({
    required this.width,
    required this.height,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(height),
        child: SizedBox(
          width: width,
          height: height,
          child: Center(child: child),
        ),
      ),
    );
  }
}