import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/primary_button_noreturn.dart';  
import 'package:eleuterra_app/textfield_rounded.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:eleuterra_app/home_screen_trip.dart';

class Createaccount extends StatefulWidget {
  const Createaccount({super.key});

  @override
  State<Createaccount> createState() => _CreateaccountState();
}
//FALTA HACER QUE RECONOZCA LOS FORMATOS DE: EMAIL, USERNAME, PHONE NUMBER, PASSWORDS

class _CreateaccountState extends State<Createaccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();

  String? _emailError;
  String? _phoneError;
  String? _usernameError;
  String? _passwordError;
  String? _repeatPasswordError;

  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

  DateTime? _selectedDob;
  String? _errorMessage;

  bool _validateFields() {
    setState(() {
      _emailError = null;
      _phoneError = null;
      _usernameError = null;
      _passwordError = null;
      _repeatPasswordError = null;
      _errorMessage = null;

      if (_emailController.text.trim().isEmpty) {
        _emailError = 'Enter your email';
      }

      if (_phoneController.text.trim().isEmpty) {
        _phoneError = 'Enter your phone number';
      }

      if (_usernameController.text.trim().isEmpty) {
        _usernameError = 'Enter your username';
      }

      if (_passController.text.trim().isEmpty) {
        _passwordError = 'Enter your password';
      }

      if (_repeatPassController.text.trim().isEmpty) {
        _repeatPasswordError = 'Repeat your password';
      } else if (_passController.text != _repeatPassController.text) {
        _repeatPasswordError = 'Passwords do not match';
      }
    });

    return _emailError == null &&
        _phoneError == null &&
        _usernameError == null &&
        _passwordError == null &&
        _repeatPasswordError == null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passController.dispose();
    _repeatPassController.dispose();
    super.dispose();
  }

  void _openDobPicker() {
    DateTime tempDate = _selectedDob ?? DateTime(2000, 1, 1);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.charcoal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SizedBox(
          height: 320,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _selectedDob = tempDate);
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    brightness: Brightness.dark,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: tempDate,
                    maximumDate: DateTime.now(),
                    minimumDate: DateTime(1900, 1, 1),
                    onDateTimeChanged: (DateTime newDate) {
                      tempDate = newDate;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDob(DateTime date) {
    String dd = date.day.toString().padLeft(2, '0');
    String mm = date.month.toString().padLeft(2, '0');
    String yyyy = date.year.toString();
    return "$dd/$mm/$yyyy";
  }

  void _onContinue() {
    final isValid = _validateFields();

    if (!isValid) return;

    if (_selectedDob == null) {
      setState(() {
        _errorMessage = "Select your date of birth.";
      });
      return;
    }

    setState(() {
      _errorMessage = "Done! Your account data is valid.";
    });
  }

  @override
  Widget build(BuildContext context) {
    final dobController = TextEditingController(
      text: _selectedDob == null ? '' : _formatDob(_selectedDob!),
    );

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
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 10),
              SvgPicture.asset(
                'assets/images/Eleuterra-isotipo-naranja.svg',
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                'Create your account',
                style: AppTextStyles.subtitleMedium,
              ),
              const SizedBox(height: 20),

              const _Label(text: 'E-mail'),
              const SizedBox(height: 2),
              RoundedInput(
                hint: 'eleuterra@mail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                borderColor: AppColors.vividtangelo,
                errorText: _emailError,
              ),

              const SizedBox(height: 16),

              const _Label(text: 'Phone number'),
                const SizedBox(height: 2),

                IntlPhoneField(
                  controller: _phoneController,
                  initialCountryCode: 'US',
                  style: AppTextStyles.text,

                  dropdownTextStyle: AppTextStyles.text.copyWith(
                    color: AppColors.floralwhite,
                  ),

                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    hintStyle: AppTextStyles.text.copyWith(
                      color: const Color(0xFF7F7F7F),
                    ),

                    errorText: _phoneError,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(
                        color: AppColors.vividtangelo,
                        width: 1.2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(
                        color: AppColors.vividtangelo,
                        width: 1.6,
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: const BorderSide(color: Colors.red),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),

                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),

              const SizedBox(height: 16),

              const _Label(text: 'Username'),
              const SizedBox(height: 2),
              RoundedInput(
                hint: '@username',
                controller: _usernameController,
                keyboardType: TextInputType.text,
                borderColor: AppColors.vividtangelo,
                errorText: _usernameError,
              ),

              const SizedBox(height: 16),

              const _Label(text: 'Password'),
              const SizedBox(height: 2),
              RoundedInput(
                hint: '**************',
                controller: _passController,
                obscureText: _obscurePassword,
                borderColor: AppColors.vividtangelo,
                errorText: _passwordError,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: SvgPicture.asset(
                    _obscurePassword
                        ? 'assets/icons/closed-eye.svg'
                        : 'assets/icons/eye.svg',
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const _Label(text: 'Repeat password'),
              const SizedBox(height: 2),
              RoundedInput(
                hint: '**************',
                controller: _repeatPassController,
                obscureText: _obscureRepeatPassword,
                borderColor: AppColors.vividtangelo,
                errorText: _repeatPasswordError,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureRepeatPassword = !_obscureRepeatPassword;
                    });
                  },
                  icon: SvgPicture.asset(
                    _obscureRepeatPassword
                        ? 'assets/icons/closed-eye.svg'
                        : 'assets/icons/eye.svg',
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const _Label(text: 'Date of birth'),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: _openDobPicker,
                child: AbsorbPointer(
                  child: RoundedInput(
                    hint: 'dd/mm/yyyy',
                    controller: dobController,
                    keyboardType: TextInputType.none,
                    borderColor: AppColors.vividtangelo,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: _errorMessage!.startsWith("✅")
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
              ],

                PrimaryButtonNoreturn(
                  text: 'Continue',
                  destination: const RouteTodayScreen(),
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.04),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: AppTextStyles.placesText,
        ),
      ),
    );
  }
}