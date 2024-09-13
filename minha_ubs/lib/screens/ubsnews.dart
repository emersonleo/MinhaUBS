import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:minha_ubs/services/NoticeService.dart';

import 'mainscreen.dart';

class UBSNews extends StatefulWidget {
  const UBSNews({super.key});

  @override
  State<UBSNews> createState() => _UBSNewsState();
}

class _UBSNewsState extends State<UBSNews> {
  NoticeService noticeService = NoticeService(Client());
  Future<List<dynamic>> resultNoticeList =
      NoticeService(Client()).getNotices(1);

  TextEditingController sendNewsController = TextEditingController();

  void createNews() async {
    await noticeService.registerNotice(1, 11, sendNewsController.text);

    setState(() {
      resultNoticeList = NoticeService(Client()).getNotices(1);
      sendNewsController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 26),
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          child: IconButton(
                              color: const Color(0xFF00A038),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainScreen()),
                                );
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Center(
                            child: Text(
                              "Notícias",
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFF5C5C5C),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: sendNewsController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText:
                                  'Escreva algo aqui para criar uma nova notícia...',
                              suffixIcon: IconButton(
                                icon:
                                    const Icon(Icons.send, color: Colors.green),
                                onPressed: () {
                                  createNews();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: resultNoticeList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text(
                                    'Ocorreu um erro inesperado no carregamento dos dados'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text(
                                    'Não foram encontrados dados de famílias ou moradores.'));
                          } else {
                            final List? visits = snapshot.data?.toList();
                            return ListView.builder(
                              itemCount: visits?.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1.5),
                                  ),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 0.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.person_outline,
                                                color: Color(0xFF00A038),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(visits![index].agent.nome,
                                                style: GoogleFonts.roboto(
                                                  color:
                                                      const Color(0xFF00A038),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                              visits![index].timestamp,
                                              style: GoogleFonts.roboto(
                                                color: const Color(0xFF00A038),
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      visits![index].noticia,
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xFF5C5C5C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
