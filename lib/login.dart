import 'package:eleuterra_app/createaccount.dart';
import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/textfield_rounded.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:eleuterra_app/expandable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textGrey = Color(0xFFFCFBF0);

    return Scaffold(
      backgroundColor: AppColors.charcoal,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 10),

              SvgPicture.asset(
                'assets/images/eleuterra-logo-and-slogan.svg',
                height: 120,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 18),

              Text(
                'Log In',
                style: AppTextStyles.subtitleMedium,
              ),
              _Label(text: 'E-mail or username'),
              const SizedBox(height: 8),
              RoundedInput(
                hint: '@eleuterra',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                borderColor: AppColors.vividtangelo,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Password'),
              const SizedBox(height: 8),
              RoundedInput(
                hint: '**************',
                controller: _passController,
                obscureText: _obscurePassword,
                borderColor: AppColors.vividtangelo,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: Center(
                        child: SvgPicture.asset(
                          _obscurePassword
                              ? 'assets/icons/closed-eye.svg'
                              : 'assets/icons/eye.svg',
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              GradientShadowButton(
                text: 'Continue',
                onTap: () {
                },
                width: 190,
                height: 40,
                frontColor: AppColors.mustardyellow,
                shadowColor: AppColors.vividtangelo,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.royalorange,
                radiusBordertop: 0.45,
                radiusBorderbottom: 0.76,
                heightShadow: 1.16,
              ),

              const SizedBox(height: 12),

              Text(
                'Or',
                style: AppTextStyles.subtitleIntersection,
              ),

              const SizedBox(height: 18),

              Text(
                'Create your account',
                style: AppTextStyles.subtitleMedium,
              ),

              const SizedBox(height: 14),

              GradientShadowButton(
                text: 'Start',
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Createaccount(),
                    ),
                  );
                },
                width: 190,
                height: 44,
                frontColor: AppColors.mustardyellow,
                shadowColor: AppColors.vividtangelo,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.royalorange,
                radiusBordertop: 0.45,
                radiusBorderbottom: 0.76,
                heightShadow: 1.16,
              ),

              const SizedBox(height: 14),

              GradientShadowButton(
                onTap: () {},
                width: 190,
                height: 44,
                frontColor: AppColors.slateblue,
                shadowColor: AppColors.steelblue,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.mistyblue,
                radiusBordertop: 0.45,
                radiusBorderbottom: 0.76,
                heightShadow: 1.16,
                child: SvgPicture.asset(
                  'assets/icons/facebook_logo.svg',
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 10),

              GradientShadowButton(
                onTap: () {},
                width: 190,
                height: 44,
                frontColor: AppColors.floralwhite,
                shadowColor: const Color(0xff4d4d4d),
                textColor: AppColors.floralwhite,
                borderColor: AppColors.lightsand,
                radiusBordertop: 0.45,
                radiusBorderbottom: 0.76,
                heightShadow: 1.16,
                child: SvgPicture.asset(
                  'assets/icons/google_logo.svg',
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),

                const SizedBox(height: 20),

                /// 👇 WIDGET EXPANDIBLE (EJEMPLO VISUAL, NO VA AQUI)
                ExpandableButton(
                  title: 'Countries',

                  // mismos valores que tus botones
                  closedWidth: 190,
                  closedHeight: 44,

                  // tamaño cuando se abre (ajústalo si quieres)
                  openWidth: 370,
                  openHeight: 220,

                  frontColor: AppColors.espressobrown,
                  shadowColor: AppColors.vividtangelo,
                  textColor: AppColors.floralwhite,
                  borderColor: AppColors.royalorange,

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

                //FIN DEL BOTON EXPANDIBLE (EJEMPLO)

                const SizedBox(height: 20),

              
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontStyle: FontStyle.italic,
          color: Color(0xFFEDEDED),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}