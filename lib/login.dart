import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/textfield_rounded.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF171717); 
    const orange = Color(0xFFF37927);
    const orangeShadow = Color.fromARGB(255, 30, 26, 21);
    const textGrey = Color(0xFFFCFBF0);
    //primary colors
    //const vividtangelo = Color(0xFFF37927);
    //const royalorange = Color(0xFFF89F42);
    //const floralwhite = Color(0xFFFCFBF0);
    //const espressobrown = Color(0xFF282224);
    //secondary colors
    //const mustardyellow = Color(0xFFFFB81C);
    //const earthybrown = Color(0xFF5D3923);
    //const lightsand = Color(0xFFF1E2C5);
    //const lightgray = Color(0xFFF1EEE7);
    //const forestgreen = Color(0xFF006644);
    //const turquoiseblue = Color(0xFF00788C);
    //const mossgreen = Color(0xFF718D2A);
    //const steelblue = Color(0xFF46505A);
    //const mistyblue = Color(0xFF9BB7D4);
    //const mediumcarmine = Color(0xFFB04B25);
    //const peachorange = Color(0xFFFCCD9D);
    //const slateblue = Color(0xFF3A75C4);
    //const olivedrab = Color(0xFF858F1F);
    //const terrared = Color(0xFFE87552);
    //const deepred = Color(0xFFB5121B);
    //const deepteal = Color(0xFF007577);
    

    return Scaffold(
      backgroundColor: bg,
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

              // LOGO (imagen)
              Image.asset(
                'assets/images/eleutera_logo.png',
                height: 120,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 18),

              const Text(
                'Log In',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 22),

              // Label + Field
              _Label(text: 'E-mail or username'),
              const SizedBox(height: 8),
              RoundedInput(
                hint: '@eleuterra',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                borderColor: orange,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Password'),
              const SizedBox(height: 8),
              RoundedInput(
                hint: '**************',
                controller: _passController,
                obscureText: true,
                borderColor: orange,
              ),

              const SizedBox(height: 18),

              // Continue button (con “doble capa”/sombra de color)
              GradientShadowButton(
                text: 'Continue',
                onTap: () {},
                width: 300,
                height: 40,
                frontColor: orange,
                shadowColor: orangeShadow,
                textColor: Colors.white,
              ),

              const SizedBox(height: 12),

              const Text(
                'Or',
                style: TextStyle(
                  color: textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Create your account',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 14),

              // Start button (mismo estilo)
              GradientShadowButton(
                text: 'Start',
                onTap: () {
                  // TODO: go to register
                },
                width: 190,
                height: 44,
                frontColor: orange,
                shadowColor: orangeShadow,
                textColor: Colors.white,
              ),

              const SizedBox(height: 14),

              // Facebook button
              SocialButton(
                text: 'facebook',
                onTap: () {},
                background: const Color(0xFF2D62D3),
                textColor: Colors.white,
              ),

              const SizedBox(height: 10),

              // Google button
              SocialButton(
                text: 'Google',
                onTap: () {},
                background: const Color(0xFFF2F2F2),
                textColor: Colors.black87,
                border: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
              ),

              const SizedBox(height: 20),

              GestureDetector(
  onTap: () {

  },
  child: Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: orange, // capa externa
      borderRadius: BorderRadius.circular(40),
    ),
    child: Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color(0xFFFDB71D), // capa intermedia
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.orange.shade400, // centro
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Text(
          'Program a New Route',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
),
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