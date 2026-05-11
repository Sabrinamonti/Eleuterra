import 'package:flutter/material.dart';

import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/trivia_button.dart';
import 'package:eleuterra_app/status_buttons.dart';
import 'package:eleuterra_app/main_menu.dart';

class TriviaOptions extends StatelessWidget {
  const TriviaOptions({super.key});

  static const double _screenWidth = 440;
  static const double _horizontalPadding = 15;
  static const double _buttonWidth = _screenWidth - (_horizontalPadding * 2);
  static const double _buttonHeight = 125;

  void _openCityOverlay(BuildContext context) {
    // TODO: abrir overlay de ciudad
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoal,
      bottomNavigationBar: MainMenu(
  currentItem: MainMenuItem.trivia,
  homeDestination: HomeDestination.trip,
),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: _horizontalPadding,
                right: _horizontalPadding,
                top: 55,
              ),
              child: StatusButtons(
                onCityTap: () => _openCityOverlay(context),
                onAtlasTap: () {},
                onCoinsTap: () {},
                coins: 250,
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: _horizontalPadding,
                      right: _horizontalPadding,
                      top: 46,
                      bottom: 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keep learning',
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.floralwhite,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Proof that you\'ve learned today!',
                          style: AppTextStyles.infoText.copyWith(
                            color: AppColors.floralwhite,
                          ),
                        ),

                        const SizedBox(height: 12),

                        TriviaButton(
                          width: _buttonWidth,
                          height: _buttonHeight,
                          frontColor: AppColors.mustardyellow,
                          shadowColor: AppColors.vividtangelo,
                          borderColor: AppColors.royalorange,
                          title: 'Today\'s Tour',
                          description:
                              'You visited four places today; now practice what you\'ve learned.',
                          onTap: () {
                            // TODO: navegar a Today's Tour
                          },
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Practice your knowledge!',
                          style: AppTextStyles.infoText.copyWith(
                            color: AppColors.floralwhite,
                          ),
                        ),

                        const SizedBox(height: 12),

                        TriviaButton(
                          width: _buttonWidth,
                          height: _buttonHeight,
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

                        const SizedBox(height: 40),

                        TriviaButton(
                          width: _buttonWidth,
                          height: _buttonHeight,
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

                        const SizedBox(height: 40),

                        TriviaButton(
                          width: _buttonWidth,
                          height: _buttonHeight,
                          frontColor: AppColors.mediumcarmine,
                          shadowColor: AppColors.espressobrown,
                          borderColor: AppColors.earthybrown,
                          title: 'General Knowledge',
                          description: 'Learn more about the world you live in.',
                          onTap: () {
                            // TODO: navegar a General Knowledge
                          },
                        ),

                        const SizedBox(height: 28),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.charcoal,
                              AppColors.charcoal.withValues(alpha: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}