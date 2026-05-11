import 'package:flutter/material.dart';
import 'package:eleuterra_app/main_menu.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';

class World extends StatelessWidget {
  const World({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: AppColors.charcoal,
      bottomNavigationBar: MainMenu(
  currentItem: MainMenuItem.world,
  homeDestination: HomeDestination.trip,
),
      body: Center(child: Text('World')),
    );
  }
}