import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/expandable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eleuterra_app/main_menu.dart';

class HomeScreenTrip extends StatefulWidget {
  const HomeScreenTrip({super.key});

  @override
  State<HomeScreenTrip> createState() => _HomeScreenTripState();
}

class _HomeScreenTripState extends State<HomeScreenTrip> {
  final PageController _filtersController = PageController(viewportFraction: 1);

  bool _financeExpanded = false;
  bool _triviaExpanded = false;
  bool _notesExpanded = false;

  final List<List<_TopFilterItem>> _filterPages = const [
    [
      _TopFilterItem(label: 'Restaurant', assetName: 'svg_restaurant'),
      _TopFilterItem(label: 'Museum', assetName: 'svg_museum'),
      _TopFilterItem(label: 'Mosque', assetName: 'svg_mosque'),
      _TopFilterItem(label: 'Park', assetName: 'svg_park'),
    ],
    [
      _TopFilterItem(label: 'Bazaar', assetName: 'svg_bazaar'),
      _TopFilterItem(label: 'Viewpoint', assetName: 'svg_viewpoint'),
      _TopFilterItem(label: 'Cafe', assetName: 'svg_cafe'),
      _TopFilterItem(label: 'Hotel', assetName: 'svg_hotel'),
    ],
  ];

  @override
  void dispose() {
    _filtersController.dispose();
    super.dispose();
  }

  Future<void> _openCityOverlay() async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'city_overlay',
      barrierColor: Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (_, __, ___) {
        return const _TopDropOverlay();
      },
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopStatusBar(onCityTap: _openCityOverlay),
              const SizedBox(height: 14),
              _SearchAndFilters(
                controller: _filtersController,
                pages: _filterPages,
              ),
              const SizedBox(height: 14),
              _MapRouteCard(width: screenWidth - 40),
              const SizedBox(height: 16),
              Text(
                'You have a Route today!',
                style: AppTextStyles.textSubtitle.copyWith(
                  color: const Color(0xFFF9A044),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Day 1 Istanbul',
                style: AppTextStyles.smallSubtitle.copyWith(
                  color: const Color(0xFFF0E2C5),
                ),
              ),
              const SizedBox(height: 10),
              _BulletInfoRow(
                iconAsset: 'svg_dot',
                text: 'This tour will take you 7 h 30 m to enjoy completely',
              ),
              const SizedBox(height: 6),
              _BulletInfoRow(
                iconAsset: 'svg_dot',
                text:
                    'We recommend leaving at 9:00 so you can enjoy your route calmly',
              ),
              const SizedBox(height: 10),
              const _RouteSummaryDivider(),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.text.copyWith(
                    color: const Color(0xFFF0E2C5),
                  ),
                  children: [
                    const TextSpan(text: 'Your trip is from '),
                    TextSpan(
                      text: 'March 23 to April 12',
                      style: AppTextStyles.boldText.copyWith(
                        color: const Color(0xFFF0E2C5),
                      ),
                    ),
                    const TextSpan(text: '  ·  '),
                    TextSpan(
                      text: '19 days left!',
                      style: AppTextStyles.boldText.copyWith(
                        color: const Color(0xFFF9A044),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'For this tour we recommend you talk or bike',
                style: AppTextStyles.text.copyWith(
                  color: const Color(0xFFF0E2C5),
                ),
              ),
              Text(
                'By Walk',
                style: AppTextStyles.placesSubtitle.copyWith(
                  color: const Color(0xFFF0E2C5),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Today's Schedule",
                style: AppTextStyles.boldText.copyWith(
                  color: const Color(0xFFF0E2C5),
                ),
              ),
              const SizedBox(height: 8),
              const _ScheduleList(),
              const SizedBox(height: 12),
              Text(
                'Health Info',
                style: AppTextStyles.boldText.copyWith(
                  color: const Color(0xFFF0E2C5),
                ),
              ),
              const SizedBox(height: 8),
              _BulletInfoRow(
                iconAsset: 'svg_dot',
                text: 'Weather: 20° Cloudy Sunny.',
              ),
              const SizedBox(height: 6),
              _BulletInfoRow(
                iconAsset: 'svg_dot',
                text:
                    'Approximate daily steps for your trip today: tour: 14,000 steps!',
              ),
              const SizedBox(height: 6),
              _BulletInfoRow(
                iconAsset: 'svg_dot',
                text: "Don't forget to drink water!",
              ),
              const SizedBox(height: 18),
              Center(
                child: Column(
                  children: [
                    GradientShadowButton(
                      text: 'Check your trip',
                      onTap: () {},
                      width: 185,
                      height: 34,
                      frontColor: const Color(0xFF282224),
                      shadowColor: const Color(0xFFF37927),
                      textColor: const Color(0xFFF0E2C5),
                      borderColor: const Color(0xFFF9A044),
                      heightShadow: 1.16,
                      radiusBordertop: 0.45,
                      radiusBorderbottom: 0.76,
                    ),
                    const SizedBox(height: 8),
                    GradientShadowButton(
                      text: 'Program a New Trip',
                      onTap: () {},
                      width: 215,
                      height: 34,
                      frontColor: const Color(0xFF282224),
                      shadowColor: const Color(0xFFF37927),
                      textColor: const Color(0xFFF0E2C5),
                      borderColor: const Color(0xFFF9A044),
                      heightShadow: 1.16,
                      radiusBordertop: 0.45,
                      radiusBorderbottom: 0.76,
                    ),
                    const SizedBox(height: 8),
                    GradientShadowButton(
                      text: 'Program a New Route',
                      onTap: () {},
                      width: 220,
                      height: 34,
                      frontColor: const Color(0xFF282224),
                      shadowColor: const Color(0xFFF37927),
                      textColor: const Color(0xFFF0E2C5),
                      borderColor: const Color(0xFFF9A044),
                      heightShadow: 1.16,
                      radiusBordertop: 0.45,
                      radiusBorderbottom: 0.76,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              ExpandableButton(
                title: 'Finance',

                // mismos valores que tus botones
                closedWidth: 370,
                closedHeight: 44,

                // tamaño cuando se abre (ajústalo si quieres)
                openWidth: 370,
                openHeight: 220,

                frontColor: AppColors.olivedrab,
                shadowColor: AppColors.forestgreen,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.mossgreen,

                items: [
                  ExpandableItem(
                    label: 'Argentina',
                    trailing: SvgPicture.asset(
                      'assets/flags/argentina.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Bolivia',
                    trailing: SvgPicture.asset(
                      'assets/flags/bolivia.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Brazil',
                    trailing: SvgPicture.asset(
                      'assets/flags/brazil.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Chile',
                    trailing: SvgPicture.asset(
                      'assets/flags/chile.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Dominican Republic',
                    trailing: SvgPicture.asset(
                      'assets/flags/dominicanrepublic.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Ireland',
                    trailing: SvgPicture.asset(
                      'assets/flags/ireland.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Mexico',
                    trailing: SvgPicture.asset(
                      'assets/flags/mexico.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Morocco',
                    trailing: SvgPicture.asset(
                      'assets/flags/morocco.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Panama',
                    trailing: SvgPicture.asset(
                      'assets/flags/panama.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Turkiye',
                    trailing: SvgPicture.asset(
                      'assets/flags/turkiye.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'United States of America',
                    trailing: SvgPicture.asset(
                      'assets/flags/usa.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Uruguay',
                    trailing: SvgPicture.asset(
                      'assets/flags/uruguay.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              ExpandableButton(
                title: 'Trivia',

                // mismos valores que tus botones
                closedWidth: 370,
                closedHeight: 44,

                // tamaño cuando se abre (ajústalo si quieres)
                openWidth: 370,
                openHeight: 220,

                frontColor: AppColors.mistyblue,
                shadowColor: AppColors.steelblue,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.slateblue,

                items: [
                  ExpandableItem(
                    label: 'Argentina',
                    trailing: SvgPicture.asset(
                      'assets/flags/argentina.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Bolivia',
                    trailing: SvgPicture.asset(
                      'assets/flags/bolivia.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Brazil',
                    trailing: SvgPicture.asset(
                      'assets/flags/brazil.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Chile',
                    trailing: SvgPicture.asset(
                      'assets/flags/chile.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Dominican Republic',
                    trailing: SvgPicture.asset(
                      'assets/flags/dominicanrepublic.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Ireland',
                    trailing: SvgPicture.asset(
                      'assets/flags/ireland.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Mexico',
                    trailing: SvgPicture.asset(
                      'assets/flags/mexico.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Morocco',
                    trailing: SvgPicture.asset(
                      'assets/flags/morocco.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Panama',
                    trailing: SvgPicture.asset(
                      'assets/flags/panama.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Turkiye',
                    trailing: SvgPicture.asset(
                      'assets/flags/turkiye.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'United States of America',
                    trailing: SvgPicture.asset(
                      'assets/flags/usa.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Uruguay',
                    trailing: SvgPicture.asset(
                      'assets/flags/uruguay.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ExpandableButton(
                title: 'Notes',

                // mismos valores que tus botones
                closedWidth: 370,
                closedHeight: 44,

                // tamaño cuando se abre (ajústalo si quieres)
                openWidth: 370,
                openHeight: 220,

                frontColor: AppColors.mediumcarmine,
                shadowColor: AppColors.espressobrown,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.earthybrown,

                items: [
                  ExpandableItem(
                    label: 'Argentina',
                    trailing: SvgPicture.asset(
                      'assets/flags/argentina.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Bolivia',
                    trailing: SvgPicture.asset(
                      'assets/flags/bolivia.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Brazil',
                    trailing: SvgPicture.asset(
                      'assets/flags/brazil.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Chile',
                    trailing: SvgPicture.asset(
                      'assets/flags/chile.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Dominican Republic',
                    trailing: SvgPicture.asset(
                      'assets/flags/dominicanrepublic.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Ireland',
                    trailing: SvgPicture.asset(
                      'assets/flags/ireland.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Mexico',
                    trailing: SvgPicture.asset(
                      'assets/flags/mexico.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Morocco',
                    trailing: SvgPicture.asset(
                      'assets/flags/morocco.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Panama',
                    trailing: SvgPicture.asset(
                      'assets/flags/panama.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Turkiye',
                    trailing: SvgPicture.asset(
                      'assets/flags/turkiye.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'United States of America',
                    trailing: SvgPicture.asset(
                      'assets/flags/usa.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                  ExpandableItem(
                    label: 'Uruguay',
                    trailing: SvgPicture.asset(
                      'assets/flags/uruguay.svg',
                      width: 24,
                      height: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                'Trophies',
                style: AppTextStyles.title.copyWith(
                  color: const Color(0xFFF0E2C5),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              GradientShadowButton(
                onTap: () {},
                width: screenWidth - 40,
                height: 92,
                frontColor: const Color(0xFF282224),
                shadowColor: const Color(0xFF333333),
                textColor: const Color(0xFFF0E2C5),
                borderColor: const Color(0xFF4E4D4E),
                child: const _TrophiesContent(),
              ),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  'No trophies earned in Istanbul yet!',
                  style: AppTextStyles.text.copyWith(
                    color: const Color(0xFF666A6D),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Claim your Annual Gift!',
                  style: AppTextStyles.boldText.copyWith(
                    color: const Color(0xFFF9A044),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SvgPicture.asset(
                  'assets/svg/svg_gift_box.svg',
                  height: 54,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Terms and Conditions',
                    style: AppTextStyles.text.copyWith(
                      color: const Color(0xFF666A6D),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF666A6D),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainMenu(
        currentItem: MainMenuItem.home,
        homeDestination: HomeDestination.trip,
      ),
    );
  }
}

class _TopStatusBar extends StatelessWidget {
  final VoidCallback onCityTap;

  const _TopStatusBar({required this.onCityTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ThinBorderPillButton(
            height: 28,
            onTap: onCityTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/svg_istanbul_flag.svg',
                  height: 14,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Istanbul, Türkiye',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.text.copyWith(
                      color: const Color(0xFFF0E2C5),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        ThinBorderPillButton(
          width: 88,
          height: 28,
          onTap: () {},
          child: SvgPicture.asset('assets/svg/svg_atlas_plus.svg', height: 14),
        ),
        const SizedBox(width: 8),
        ThinBorderPillButton(
          width: 70,
          height: 28,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/svg_coin.svg', height: 14),
              const SizedBox(width: 6),
              Text(
                '550',
                style: AppTextStyles.text.copyWith(
                  color: const Color(0xFFF0E2C5),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchAndFilters extends StatelessWidget {
  final PageController controller;
  final List<List<_TopFilterItem>> pages;

  const _SearchAndFilters({required this.controller, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThinBorderPillButton(
          height: 33,
          onTap: () {},
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              SvgPicture.asset('assets/svg/svg_lupa.svg', height: 16),
              const SizedBox(width: 8),
              Text(
                'Search route',
                style: AppTextStyles.text.copyWith(
                  color: const Color(0xFF8F836D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapRouteCard extends StatelessWidget {
  final double width;

  const _MapRouteCard({required this.width});

  @override
  Widget build(BuildContext context) {
    return GradientShadowButton(
      onTap: () {},
      width: width,
      height: 100,
      frontColor: const Color(0xFF282224),
      shadowColor: const Color(0xFFF37927),
      textColor: const Color(0xFFF0E2C5),
      borderColor: const Color(0xFFF9A044),
      radiusBordertop: 0.05,
      radiusBorderbottom: 0.12,
      heightShadow: 1.05,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/mock_route_map.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 10,
            top: 18,
            child: _MapPoint(number: '1', color: const Color(0xFFF9A044)),
          ),
          Positioned(
            left: 65,
            bottom: 14,
            child: _MapPoint(number: '2', color: const Color(0xFF7F8D44)),
          ),
          Positioned(
            left: 118,
            top: 52,
            child: _MapPoint(number: '3', color: const Color(0xFF7F94C8)),
          ),
        ],
      ),
    );
  }
}

class _MapPoint extends StatelessWidget {
  final String number;
  final Color color;

  const _MapPoint({required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: AppTextStyles.boldText.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _BulletInfoRow extends StatelessWidget {
  final String iconAsset;
  final String text;

  const _BulletInfoRow({required this.iconAsset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: SvgPicture.asset('assets/svg/$iconAsset.svg', height: 10),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.text.copyWith(color: const Color(0xFFF0E2C5)),
          ),
        ),
      ],
    );
  }
}

class _RouteSummaryDivider extends StatelessWidget {
  const _RouteSummaryDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xFFF0E2C5),
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList();

  @override
  Widget build(BuildContext context) {
    const rows = [
      ('Levant', '10 minutes.'),
      ('Grand Bazaar', '15 minutes.'),
      ('Sulat Ahmet Mosque', '35 minutes.'),
      ('Hagia Sofia Mosque', '120 minutes.'),
      ('Yerebatan Sarnici', '45 minutes.'),
      ('Topkapi Palace', '2.5 hours.'),
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Place',
                style: AppTextStyles.text.copyWith(
                  color: const Color(0xFFF0E2C5),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                'Start',
                textAlign: TextAlign.left,
                style: AppTextStyles.text.copyWith(
                  color: const Color(0xFFF0E2C5),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/svg_dot.svg', height: 10),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          row.$1,
                          style: AppTextStyles.text.copyWith(
                            color: const Color(0xFFF0E2C5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    row.$2,
                    style: AppTextStyles.text.copyWith(
                      color: const Color(0xFFF0E2C5),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ExpandableActionButton extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Color frontColor;
  final Color borderColor;
  final Color shadowColor;
  final Widget child;

  const _ExpandableActionButton({
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.frontColor,
    required this.borderColor,
    required this.shadowColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GradientShadowButton(
            text: title,
            onTap: onTap,
            width: MediaQuery.sizeOf(context).width - 60,
            height: 34,
            frontColor: frontColor,
            shadowColor: shadowColor,
            textColor: const Color(0xFFF0E2C5),
            borderColor: borderColor,
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: child,
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
        ),
      ],
    );
  }
}

class _PlaceholderExpandedContent extends StatelessWidget {
  final String title;

  const _PlaceholderExpandedContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF201B1D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF3A3436)),
      ),
      child: Text(
        '$title overlay / expanded content placeholder',
        style: AppTextStyles.text.copyWith(color: const Color(0xFFF0E2C5)),
      ),
    );
  }
}

class _TrophiesContent extends StatelessWidget {
  const _TrophiesContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [_TrophySlot(), _TrophySlot(), _TrophySlot()],
    );
  }
}

class _TrophySlot extends StatelessWidget {
  const _TrophySlot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF5B5B5B)),
      ),
      child: Center(
        child: SvgPicture.asset('assets/svg/svg_trophy_star.svg', height: 24),
      ),
    );
  }
}

class ThinBorderPillButton extends StatelessWidget {
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final VoidCallback onTap;

  const ThinBorderPillButton({
    super.key,
    this.width,
    required this.height,
    required this.child,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(height * 0.7),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: const Color(0xFF282224),
            borderRadius: BorderRadius.circular(height * 0.7),
            border: Border.all(color: const Color(0xFFF9A044), width: 1.2),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class _TopDropOverlay extends StatelessWidget {
  const _TopDropOverlay();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF201A1C),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFF9A044), width: 1.3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'City overlay',
                      style: AppTextStyles.boldText.copyWith(
                        color: const Color(0xFFF9A044),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Color(0xFFF0E2C5)),
                    ),
                  ],
                ),
                Text(
                  'Este panel queda en blanco por ahora, pero ya tiene la caída desde el borde superior y el cierre.',
                  style: AppTextStyles.text.copyWith(
                    color: const Color(0xFFF0E2C5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopFilterItem {
  final String label;
  final String assetName;

  const _TopFilterItem({required this.label, required this.assetName});
}
