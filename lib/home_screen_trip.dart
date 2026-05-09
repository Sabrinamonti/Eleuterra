import 'package:eleuterra_app/expandable_button.dart';
import 'package:eleuterra_app/big_button.dart';
import 'package:eleuterra_app/main_menu.dart';
import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/top_trip_status_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color _background = AppColors.charcoal;
const Color _frontDark = AppColors.espressobrown;
const Color _cream = AppColors.lightsand;
const Color _orange = AppColors.royalorange;
const Color _deepOrange = AppColors.vividtangelo;
const Color _mutedText = AppColors.midnightgrey;

class HomeScreenTrip extends StatelessWidget {
  const HomeScreenTrip({super.key});

  Future<void> _openCityOverlay(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'city_overlay',
      barrierColor: Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (_, __, ___) => const _TopDropOverlay(),
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
          child: FadeTransition(
            opacity: curved,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double contentWidth = screenWidth - 40;
    final double mapWidth = contentWidth.clamp(0.0, 390.0).toDouble();

    // MODIFICA EL ALTO DEL MAPA ACA.
    const double mapHeight = 170;

    return Scaffold(
      backgroundColor: AppColors.charcoal,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTripStatusButtons(
                onCityTap: () => _openCityOverlay(context),
                onAtlasTap: () {},
                onCoinsTap: () {},
                coins: 250,
              ),

              const SizedBox(height: 14),

              const _SearchBar(),

              const SizedBox(height: 14),

              Center(
                child: BigButton(
                  width: mapWidth,
                  height: mapHeight,
                  frontColor: AppColors.espressobrown,
                  shadowColor: AppColors.vividtangelo,
                  borderColor: AppColors.royalorange,
                  borderWidth: 5.5,
                  borderRadius: 28,
                  shadowOffset: 14,
                  onTap: () {},

                  // Luego reemplaza esto por tu API de mapa:
                  // child: GoogleMap(...),
                  child: const SizedBox.expand(),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'You have a Route today!',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.royalorange,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                'Day 1 Istanbul',
                style: AppTextStyles.smallSubtitle.copyWith(
                  color: AppColors.lightsand,
                ),
              ),

              const SizedBox(height: 10),

              const _IconTextRow(
                assetPath: 'assets/icons/clock.svg',
                text: 'This tour will take you: 6:10 hours approxapproximately.',
                iconSize: 16,
              ),

              const SizedBox(height: 6),

              const _IconTextRow(
                assetPath: 'assets/icons/alarm.svg',
                text:
                    'We recommend leaving at 9:00 so you can enjoy your route calmly',
                iconSize: 16,
              ),

              const SizedBox(height: 10),

              const Divider(
                color: AppColors.lightsand,
                height: 1,
                thickness: 1,
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: AppTextStyles.text.copyWith(
                        color: AppColors.lightsand,
                        ),
                        children: [
                          const TextSpan(text: 'Your trip is: from '),
                          TextSpan(
                            text: 'March 23 to April 12',
                            style: AppTextStyles.text.copyWith(
                            color: AppColors.lightsand,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    '19 days left!',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.text.copyWith(
                      color: AppColors.royalorange,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                'For this tour we recommend you Walk or Bike',
                style: AppTextStyles.optionsSub.copyWith(
                  color: AppColors.lightsand,
                ),
              ),

              const SizedBox(height: 1),

              Text(
                'By Walk',
                style: AppTextStyles.textSubtitle.copyWith(
                  color: AppColors.lightsand,
                ),
              ),

              const SizedBox(height: 1),

              Text(
                "Today's Schedule",
                style: AppTextStyles.textSmallSubtitle.copyWith(
                  color: AppColors.lightsand,
                ),
              ),

              const SizedBox(height: 8),

              const _ScheduleList(),

              const SizedBox(height: 12),

              Text(
                'Health info.',
                style: AppTextStyles.textSmallSubtitle.copyWith(
                  color: AppColors.lightsand,
                ),
              ),

              const SizedBox(height: 8),

              const _IconTextRow(
                assetPath: 'assets/icons/weather.svg',
                text: 'Weather: 25 °C Mostly Sunny.',
                iconSize: 12,
              ),

              const SizedBox(height: 6),

              const _IconTextRow(
                assetPath: 'assets/icons/walk.svg',
                text:
                    "Approximate steps you will take on today's tour: 16,000 steps!",
                iconSize: 16,
              ),

              const SizedBox(height: 6),

              _IconTextRow(
                assetPath: 'assets/icons/drop.svg',
                text: "Don’t forget to drink water!",
                iconSize: 16,
                textStyle: AppTextStyles.boldText.copyWith(
                  color: AppColors.lightsand,
                ),
              ),

              const SizedBox(height: 18),

              const _TripButtons(),

              const SizedBox(height: 18),

              _SectionExpandableButton(
                title: 'Finance', 
                frontColor: AppColors.olivedrab,
                shadowColor: AppColors.forestgreen,
                borderColor: AppColors.mossgreen,
              ),

              const SizedBox(height: 10),

              _SectionExpandableButton(
                title: 'Trivia',
                frontColor: AppColors.mistyblue,
                shadowColor: AppColors.steelblue,
                borderColor: AppColors.slateblue,
              ),

              const SizedBox(height: 10),

              _SectionExpandableButton(
                title: 'Notes',
                frontColor: AppColors.mediumcarmine,
                shadowColor: AppColors.espressobrown,
                borderColor: AppColors.earthybrown,
              ),

              const SizedBox(height: 18),

              Text(
                'Trophies',
                style: AppTextStyles.textSubtitle.copyWith(
                  color: AppColors.lightsand,
                  fontSize: 36,
                ),
              ),

              const SizedBox(height: 10),

Center(
                child: BigButton(
                  width: mapWidth,
                  height: mapHeight,
                frontColor: AppColors.espressobrown,
                shadowColor: const Color(0xFF333333),
                borderColor: const Color(0xFF4E4D4E),
                  borderWidth: 5.5,
                  borderRadius: 28,
                  shadowOffset: 14,
                  onTap: () {},

                  child: const SizedBox.expand(),
                ),
              ),


              const SizedBox(height: 14),

              Center(
                child: Text(
                  'No trophies earned in Istanbul yet!',
                  style: AppTextStyles.text.copyWith(
                    color: AppColors.midnightgrey,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Center(
                child: Text(
                  'Claim your Annual Gift!',
                  style: AppTextStyles.boldText.copyWith(
                    color: AppColors.royalorange,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: SvgPicture.asset(
                  'assets/icons/gift.svg',
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
                      color: AppColors.midnightgrey,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.midnightgrey,
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return ThinBorderPillButton(
      height: 33,
      onTap: () {},
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/glass.svg',
            height: 12,
          ),
          const SizedBox(width: 8),
          Text(
            'Search route',
            style: AppTextStyles.text.copyWith(
              color: AppColors.midnightgrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconTextRow extends StatelessWidget {
  final String assetPath;
  final String text;
  final double iconSize;
  final double iconBoxWidth;
  final TextStyle? textStyle;

  const _IconTextRow({
    required this.assetPath,
    required this.text,
    this.iconSize = 16,
    this.iconBoxWidth = 24,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = textStyle ??
        AppTextStyles.text.copyWith(
          color: AppColors.lightsand,
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: iconBoxWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                assetPath,
                height: iconSize,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            text,
            style: effectiveTextStyle,
          ),
        ),
      ],
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList();

  static const double _startColumnWidth = 160;
  static const double _iconSlotWidth = 16;
  static const double _iconTextGap = 4;
  static const double _Indent = 16;


  static const List<_ScheduleEntry> _rows = [
    _ScheduleEntry(
      place: 'Walk',
      start: '10 minutes.',
      iconAsset: 'assets/icons/dot.svg',
      iconSize: 10,
      indent: true,
    ),
    _ScheduleEntry(
      place: 'Grand Bazaar',
      start: '1:05 hours.',
      iconAsset: 'assets/icons/1.svg',
      iconSize: 16,
    ),
    _ScheduleEntry(
      place: 'Walk',
      start: '15 minutes.',
      iconAsset: 'assets/icons/dot.svg',
      iconSize: 10,
      indent: true,
    ),
    _ScheduleEntry(
      place: 'Sultan Ahmed Mosque',
      start: '35 minutes.',
      iconAsset: 'assets/icons/2.svg',
      iconSize: 16,
    ),
    _ScheduleEntry(
      place: 'Walk',
      start: '10 minutes.',
      iconAsset: 'assets/icons/dot.svg',
      iconSize: 10,
      indent: true,
    ),
    _ScheduleEntry(
      place: 'Hagia Sofia Mosque',
      start: '1:30 hours.',
      iconAsset: 'assets/icons/3.svg',
      iconSize: 16,
    ),
    _ScheduleEntry(
      place: 'Walk',
      start: '45 minutes.',
      iconAsset: 'assets/icons/dot.svg',
      iconSize: 10,
      indent: true,
    ),
    _ScheduleEntry(
      place: 'Topkapi Palace',
      start: '2:15 hours.',
      iconAsset: 'assets/icons/4.svg',
      iconSize: 16,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final headerStyle = AppTextStyles.boldText.copyWith(
      color: AppColors.lightsand,
    );

    final rowStyle = AppTextStyles.text.copyWith(
      color: AppColors.lightsand,
    );

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: _iconSlotWidth,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/pin.svg',
                        height: 16,
                      ),
                    ),
                  ),

                  const SizedBox(width: _iconTextGap),

                  Expanded(
                    child: Text(
                      'Location',
                      style: headerStyle,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: _startColumnWidth,
              child: Text(
                'Start',
                style: headerStyle,
              ),
            ),
          ],
        ),

        const SizedBox(height: 0.5),

        for (final item in _rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 0.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (item.indent) const SizedBox(width: _Indent),

                      SizedBox(
                        width: _iconSlotWidth,
                        child: Center(
                          child: SvgPicture.asset(
                            item.iconAsset,
                            height: item.iconSize,
                          ),
                        ),
                      ),

                      const SizedBox(width: _iconTextGap),

                      Expanded(
                        child: Text(
                          item.place,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: rowStyle,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: _startColumnWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: item.indent ? _Indent : 0,
                    ),
                    child: Text(
                      item.start,
                      style: rowStyle,
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

class _ScheduleEntry {
  final String place;
  final String start;
  final String iconAsset;
  final bool indent;
  final double iconSize;

  const _ScheduleEntry({
    required this.place,
    required this.start,
    required this.iconAsset,
    this.indent = false,
    this.iconSize = 16,
  });
}

class _TripButtons extends StatelessWidget {
  const _TripButtons();

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = AppTextStyles.smallSubtitle.copyWith(
      color: AppColors.lightsand,
      height: 1,
    );

    return Center(
      child: Column(
        children: [
          GradientShadowButton(
            onTap: () {},
            width: 160,
            height: 34,
            frontColor: AppColors.espressobrown,
            shadowColor: AppColors.vividtangelo,
            textColor: AppColors.lightsand,
            borderColor: AppColors.royalorange,
            heightShadow: 1.16,
            radiusBordertop: 0.45,
            radiusBorderbottom: 0.76,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/rodo_happy.svg',
                    height: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Check Your Trip',
                    maxLines: 1,
                    style: buttonTextStyle,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          GradientShadowButton(
            onTap: () {},
            width: 290,
            height: 34,
            frontColor: AppColors.espressobrown,
            shadowColor: AppColors.vividtangelo,
            textColor: AppColors.lightsand,
            borderColor: AppColors.royalorange,
            heightShadow: 1.16,
            radiusBordertop: 0.45,
            radiusBorderbottom: 0.76,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Program a New Route',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: buttonTextStyle,
              ),
            ),
          ),

          const SizedBox(height: 8),

          GradientShadowButton(
            onTap: () {},
            width: 290,
            height: 34,
            frontColor: AppColors.espressobrown,
            shadowColor: AppColors.vividtangelo,
            textColor: AppColors.lightsand,
            borderColor: AppColors.royalorange,
            heightShadow: 1.16,
            radiusBordertop: 0.45,
            radiusBorderbottom: 0.76,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Program a New Trip',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionExpandableButton extends StatelessWidget {
  final String title;
  final Color frontColor;
  final Color shadowColor;
  final Color borderColor;

  const _SectionExpandableButton({
    required this.title,
    required this.frontColor,
    required this.shadowColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final double contentWidth = MediaQuery.sizeOf(context).width - 40;

    return Center(
      child: ExpandableButton(
        title: title,
        closedWidth: contentWidth.clamp(0.0, 370.0).toDouble(),
        closedHeight: 44,
        openWidth: contentWidth.clamp(0.0, 390.0).toDouble(),
        openHeight: 235,
        frontColor: frontColor,
        shadowColor: shadowColor,
        textColor: AppColors.floralwhite,
        borderColor: borderColor,
        items: _countryItems,
      ),
    );
  }
}

final List<ExpandableItem> _countryItems = [
  _country('Argentina', 'argentina'),
  _country('Bolivia', 'bolivia'),
  _country('Brazil', 'brazil'),
  _country('Chile', 'chile'),
  _country('Dominican Republic', 'dominicanrepublic'),
  _country('Ireland', 'ireland'),
  _country('Mexico', 'mexico'),
  _country('Morocco', 'morocco'),
  _country('Panama', 'panama'),
  _country('Turkiye', 'turkiye'),
  _country('United States of America', 'usa'),
  _country('Uruguay', 'uruguay'),
];

ExpandableItem _country(String label, String flagName) {
  return ExpandableItem(
    label: label,
    trailing: SvgPicture.asset(
      'assets/flags/$flagName.svg',
      width: 24,
      height: 16,
    ),
  );
}

class _TrophiesContent extends StatelessWidget {
  const _TrophiesContent();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TrophySlot(),
        _TrophySlot(),
        _TrophySlot(),
      ],
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
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:AppColors.midnightgrey,
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/svg_trophy_star.svg',
          height: 24,
        ),
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
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.charcoal,
            borderRadius: BorderRadius.circular(height * 0.7),
            border: Border.all(
              color: AppColors.royalorange,
              width: 1.2,
            ),
          ),
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
              color: AppColors.charcoal,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.royalorange,
                width: 1.3,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.charcoal,
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
                        color: AppColors.royalorange,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.lightsand,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Este panel queda en blanco por ahora, pero ya tiene la caída desde el borde superior y el cierre.',
                  style: AppTextStyles.text.copyWith(
                    color: AppColors.lightsand,
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