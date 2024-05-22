import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:minha_ubs/DTOs/UserDTO.dart';
import 'package:minha_ubs/components/StatefullTextFieldBuilder.dart';
import 'package:minha_ubs/components/TextFieldBuilder.dart';
import 'package:minha_ubs/screens/mainscreen.dart';
import 'package:minha_ubs/screens/signin.dart';
import 'package:minha_ubs/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObscureText = true;
  UserService userService = UserService(Client());

  @override
  Widget build(BuildContext context) {
    TextFieldBuilder loginTextField =
        TextFieldBuilder("Email", Icons.alternate_email, this, loginController);
    StatefullTextFieldBuilder senhaTextField =
        StatefullTextFieldBuilder("Senha", Icons.lock, passwordController);

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
          child: ListView(
            children: [
              getLogo(),
              loginTextField.getTextfield(),
              senhaTextField,
              ElevatedButton(
                onPressed: () async {
                  String login = loginController.text;
                  String password = passwordController.text;
                  Map userDataLogin = {"email": login, "senha": password};
                  Future<UserDTO> userAuthenticated =
                      userService.loginRequest(userDataLogin);
                  final prefs = await SharedPreferences.getInstance();
                  if (prefs.getString('user') != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A038),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Entrar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Signin()),
                  );
                },
                child: Text(
                  'Cadastre-se',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF00521D),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column getLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("images/minhaUbsICon.png", width: 70, height: 70),
        Text(
          "Minha UBS",
          style: GoogleFonts.notoSans(
            //color: Color(0x00A038),
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
