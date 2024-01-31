import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getLogo(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Login',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Senha',
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  // Column getLoginFields() {
  //   return const Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Row(
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  //             child: TextField(
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'Enter a search term',
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  //             child: TextField(
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'Enter a search term',
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
