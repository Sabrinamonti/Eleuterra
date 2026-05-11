import 'package:flutter/material.dart';
import 'package:eleuterra_app/main_menu.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoal,
      bottomNavigationBar: MainMenu(
        currentItem: MainMenuItem.news,
        homeDestination: HomeDestination.trip,
      ),
      body: Center(child: Text('News')),
    );
  }
}
