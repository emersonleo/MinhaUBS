import 'package:flutter/material.dart';

import '../components/StatefullTextFieldBuilder.dart';
import '../components/TextBuilder.dart';
import '../components/TextFieldBuilder.dart';
import 'login.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController foneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextBuilder signinTitle = TextBuilder("Cadastre-se");

    TextEditingController passwordController = new TextEditingController();
    TextEditingController confirmPasswordController =
        new TextEditingController();

    TextFieldBuilder nameTextField =
        TextFieldBuilder("Nome Completo", Icons.person, this, nomeController);
    TextFieldBuilder cpfTextField =
        TextFieldBuilder("CPF", Icons.badge_outlined, this, cpfController);
    TextFieldBuilder phoneTextField =
        TextFieldBuilder("Fone", Icons.phone, this, foneController);
    TextFieldBuilder emailTextField =
        TextFieldBuilder("Email", Icons.alternate_email, this, emailController);
    StatefullTextFieldBuilder passwordTextField =
        StatefullTextFieldBuilder("Senha", Icons.lock, passwordController);
    StatefullTextFieldBuilder confirmPasswordTextField =
        StatefullTextFieldBuilder(
            "Confirme a senha", Icons.lock, confirmPasswordController);

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Center(
              child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: IconButton(
                        color: const Color(0xFF00A038),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  signinTitle.getTitleText(),
                ],
              ),
              nameTextField.getTextfield(),
              cpfTextField.getTextfield(),
              phoneTextField.getTextfield(),
              emailTextField.getTextfield(),
              passwordTextField,
              confirmPasswordTextField,
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
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
            ],
          )),
        ),
      ),
    );
  }
}
