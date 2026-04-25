import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eleuterra_app/trivia_button.dart';

class TriviaOptions extends StatelessWidget {
  const TriviaOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TopHeader(),
              const SizedBox(height: 36),
              Text(
                'Keep learning',
                style: AppTextStyles.bigTitle.copyWith(
                  color: AppColors.floralwhite,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Proof that you\'ve learned today!',
                style: AppTextStyles.infoText.copyWith(
                  color: AppColors.floralwhite,
                ),
              ),
              const SizedBox(height: 11),
              TriviaButton(
                width: 370,
                height: 130,
                frontColor: AppColors.mustardyellow,
                shadowColor: AppColors.vividtangelo,
                borderColor: AppColors.royalorange,
                title: 'Today\'s Tour',
                description:
                    'You visited four places today; now practice what you\'ve learned.',
                onTap: () {
                  // TODO: navegar a la actividad de Today\'s Tour
                },
              ),
              const SizedBox(height: 14),
              Text(
                'Practice your knowledge!',
                style: AppTextStyles.text.copyWith(
                  color: AppColors.floralwhite,
                ),
              ),
              const SizedBox(height: 14),
              TriviaButton(
                width: 400,
                height: 100,
                frontColor: AppColors.olivedrab,
                shadowColor: AppColors.forestgreen,
                borderColor: AppColors.mossgreen,
                title: 'Flags',
                description:
                    'Keep practicing until you can recognize all the flags.',
                onTap: () {
                  // TODO: navegar a Flags
                },
              ),
              const SizedBox(height: 14),
              TriviaButton(
                width: 400,
                height: 100,
                frontColor: AppColors.mistyblue,
                shadowColor: AppColors.steelblue,
                borderColor: AppColors.slateblue,
                title: 'Capitals',
                description:
                    'Practice until you know all the capitals of the world.',

                onTap: () {
                  // TODO: navegar a Capitals
                },
              ),
              const SizedBox(height: 14),
              TriviaButton(
                width: 400,
                height: 30,
                frontColor: AppColors.mediumcarmine,
                shadowColor: AppColors.espressobrown,
                borderColor: AppColors.earthybrown,
                title: 'General Knowledge',
                description: 'Learn more about the world you live in.',
                onTap: () {
                  // TODO: navegar a General Knowledge
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/flags/turkiye.svg',
                width: 30,
                height: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Istanbul, Türkiye',
                style: AppTextStyles.placesTextSmall.copyWith(
                  color: AppColors.floralwhite,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SvgPicture.asset('assets/icons/atlas_plus.svg', height: 18),
            const SizedBox(width: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/coin.svg',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '250',
                    style: AppTextStyles.text.copyWith(
                      color: AppColors.floralwhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LearningCard extends StatelessWidget {
  const _LearningCard({
    required this.width,
    required this.height,
    required this.frontColor,
    required this.shadowColor,
    required this.borderColor,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.onTap,
  });

  final double width;
  final double height;
  final Color frontColor;
  final Color shadowColor;
  final Color borderColor;
  final String title;
  final String description;
  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GradientShadowButton(
      onTap: onTap,
      width: width,
      height: height,
      frontColor: frontColor,
      shadowColor: shadowColor,
      textColor: AppColors.floralwhite,
      borderColor: borderColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.floralwhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text.copyWith(
                      color: AppColors.floralwhite,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(assetPath, width: 96, height: 96, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
