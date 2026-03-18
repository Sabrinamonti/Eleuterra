import 'package:eleuterra_app/createaccount.dart';
import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/textfield_rounded.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
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
                'assets/images/Eleuterra-isotipo-naranja.svg',
                height: 120,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 18),

              const Text(
                'Log In',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 22),

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
                width: 300,
                height: 40,
                frontColor: AppColors.mustardyellow,
                shadowColor: AppColors.vividtangelo,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.royalorange,
              ),

              const SizedBox(height: 12),

              const Text(
                'Or',
                style: TextStyle(
                  color: AppColors.floralwhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.floralwhite,
                ),
                textAlign: TextAlign.center,
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
                child: SvgPicture.asset(
                  'assets/icons/google_logo.svg',
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),

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