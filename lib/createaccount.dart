import 'package:eleuterra_app/primary_button.dart';
import 'package:eleuterra_app/textfield_rounded.dart';
import 'package:eleuterra_app/theme/app_colors.dart';
import 'package:eleuterra_app/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // <-- para el date picker con “ruedita”
import 'package:flutter_svg/flutter_svg.dart';

class Createaccount extends StatefulWidget {
  const Createaccount({super.key});

  @override
  State<Createaccount> createState() => _CreateaccountState();
}

class _CreateaccountState extends State<Createaccount> {
  // Controllers = “cajitas” donde Flutter guarda lo que el usuario escribe
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  final _repeatPassController = TextEditingController();

  // Fecha seleccionada
  DateTime? _selectedDob;

  // Mensaje de validación (ej: “las contraseñas no coinciden”)
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passController.dispose();
    _repeatPassController.dispose();
    super.dispose();
  }

  // Función para abrir el selector de fecha “con números”
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
              // Barra superior con botones
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

  // Convierte DateTime a texto dd/mm/yyyy
  String _formatDob(DateTime date) {
    String dd = date.day.toString().padLeft(2, '0');
    String mm = date.month.toString().padLeft(2, '0');
    String yyyy = date.year.toString();
    return "$dd/$mm/$yyyy";
  }

  // Validación simple al apretar “Continue”
  void _onContinue() {
    setState(() => _errorMessage = null);

    final pass = _passController.text.trim();
    final repeat = _repeatPassController.text.trim();

    // 1) Reconocimiento de igualdad de contraseñas
    if (pass != repeat) {
      setState(() => _errorMessage = "Check! Your passwords do not match.");
      return;
    }

    // 2) Verificar que haya fecha
    if (_selectedDob == null) {
      setState(() => _errorMessage = "Select your date of birth.");
      return;
    }

    // Si todo OK, puedes continuar (ej: navegar o mandar a backend)
    setState(() => _errorMessage = "✅ Done! Your passwords match!");
  }

  @override
  Widget build(BuildContext context) {
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

              // Isotipo
              SvgPicture.asset(
                'assets/images/Eleuterra-isotipo-naranja.svg',
                height: 80,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 12),

              Text(
                'Create your account', //arreglado
                style: AppTextStyles.title
              ),

              const SizedBox(height: 20),

              _Label(text: 'E-mail'),      // Agregar funcion para que si se presiona el boton y no hay texto error
              const SizedBox(height: 2),
              RoundedInput(
                hint: 'eleuterra@mail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                borderColor: AppColors.vividtangelo,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Phone number'),  //same
              const SizedBox(height: 2),
              RoundedInput(
                hint: '+000000000000',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                borderColor: AppColors.vividtangelo,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Username'),      //same 
              const SizedBox(height: 2),
              RoundedInput(
                hint: '@username',
                controller: _usernameController,
                keyboardType: TextInputType.text,
                borderColor: AppColors.vividtangelo,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Password'),      //same + ojito
              const SizedBox(height: 2),
              RoundedInput(
                hint: '**************',
                controller: _passController,
                obscureText: true,
                borderColor: AppColors.vividtangelo,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Repeat password'),      //same + ojito
              const SizedBox(height: 2),
              RoundedInput(
                hint: '**************',
                controller: _repeatPassController,
                obscureText: true,
                borderColor: AppColors.vividtangelo,
              ),

              const SizedBox(height: 16),

              _Label(text: 'Date of birth'),
              const SizedBox(height: 2),

              // Este es un “campo falso”: no escribes, lo tocas y abre el picker
              GestureDetector(
                onTap: _openDobPicker,
                child: AbsorbPointer(
                  child: RoundedInput(
                    hint: 'dd/mm/yyyy',
                    controller: TextEditingController(
                      text: _selectedDob == null ? '' : _formatDob(_selectedDob!),
                    ),
                    keyboardType: TextInputType.none,
                    borderColor: AppColors.vividtangelo,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Mensajes (errores o OK)
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

              // Botón Continue
              GradientShadowButton(
                text: 'Continue',
                onTap: _onContinue,
                width: 200,
                height: 44,
                frontColor: AppColors.mustardyellow,
                shadowColor: AppColors.vividtangelo,
                textColor: AppColors.floralwhite,
                borderColor: AppColors.royalorange,
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
      padding: EdgeInsets.only(left: screenWidth * 0.04), // 2% of screen width
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: AppTextStyles.italic,
        ),
      ),
    );
  }
}