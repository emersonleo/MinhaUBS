import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minha_ubs/utils/constants.dart';

import '../components/TextBuilder.dart';
import '../components/TextFieldBuilder.dart';
import 'login.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFieldBuilder emailTextField =
        TextFieldBuilder("email", Icons.alternate_email, this, controller);
    TextBuilder titleText = TextBuilder("Esqueci a senha");

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Center(
              child: ListView(
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
                  titleText.getTitleText(),
                ],
              ),
              Center(
                child: Text(
                  Constants.MESSAGE_RECOVERY_PASSWORD_EMAIL,
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF5C5C5C),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              emailTextField.getTextfield(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A038),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Enviar'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
