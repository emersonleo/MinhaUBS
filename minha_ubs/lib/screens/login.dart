import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minha_ubs/components/StatefullTextFieldBuilder.dart';
import 'package:minha_ubs/components/TextFieldBuilder.dart';
import 'package:minha_ubs/screens/recoverypassword.dart';
import 'package:minha_ubs/screens/signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // void initState() {
  //   super.initState();
  // }

  TextEditingController LoginController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    TextFieldBuilder loginTextField =
        TextFieldBuilder("Email", Icons.alternate_email, this, LoginController);
    StatefullTextFieldBuilder senhaTextField =
        new StatefullTextFieldBuilder("Senha", Icons.lock, PasswordController);
    // TextFieldBuilder("Senha", Icons.lock, this, PasswordController);

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getLogo(),
              loginTextField.getTextfield(),
              senhaTextField,
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecoveryPassword()),
                    );
                  },
                  child: Text(
                    'Esqueci a senha',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF00521D),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ]),
              ElevatedButton(
                onPressed: () {
                  // Ação para entrar
                },
                child: Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A038),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
                    color: Color(0xFF00521D),
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
