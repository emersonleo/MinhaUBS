import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:http/src/client.dart';

import '../components/StatefullTextFieldBuilder.dart';
import '../components/TextBuilder.dart';
import '../components/TextFieldBuilder.dart';
import '../services/UserService.dart';
import 'login.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UserService userService = UserService(Client());

  TextInputMask cpfInputMask = TextInputMask(
      mask: '999.999.999-99',
      placeholder: '_',
      maxPlaceHolders: 11,
      reverse: false);

  TextInputMask phoneInputMask =
      TextInputMask(mask: '(99) 99999-9999', reverse: false);

  @override
  Widget build(BuildContext context) {
    TextBuilder signinTitle = TextBuilder("Cadastre-se");

    TextFieldBuilder nameTextField =
        TextFieldBuilder("Nome Completo", Icons.person, this, nameController);
    TextFieldBuilder cpfTextField =
        TextFieldBuilder("CPF", Icons.badge_outlined, this, cpfController);
    TextFieldBuilder phoneTextField =
        TextFieldBuilder("Fone", Icons.phone, this, phoneController);
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
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: IconButton(
                        color: const Color(0xFF00521D),
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
              cpfTextField.getTextfieldWithMask(cpfInputMask),
              phoneTextField.getTextfieldWithMask(phoneInputMask),
              emailTextField.getTextfield(),
              passwordTextField,
              confirmPasswordTextField,
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String cpf =
                      cpfController.text.replaceAll(RegExp("[-_.]"), "");
                  String phone =
                      phoneController.text.replaceAll(RegExp("[()-\\s]"), "");
                  String email = emailController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  Map userDataSignIn = {
                    "nome": name,
                    "fone": phone,
                    "cpf": cpf,
                    "email": email,
                    "senha": password
                  };
                  userService.signInRequest(userDataSignIn);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A038),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Cadastrar'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
