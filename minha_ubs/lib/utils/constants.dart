class Constants {
  static String MESSAGE_RECOVERY_PASSWORD_EMAIL =
      "Nos informe abaixo seu email e te enviaremos um link de alteração se houver uma conta cadastrada com esse email. A partir desse link você poderá redefinir sua senha.";

  //URLs
  static String ENVIRONMENT_HOST = "http://192.168.1.15:8080/";
  static String USER_PATH = "usuario/";
  static String RESIDENT_BHU_PATH = "posto/pessoas?posto=";
  static String FAMILY_BHU_PATH = "posto/familia?posto=";
  static String REGISTER_CASE_PATH = "posto/registrarcaso";
  static String LIST_CASE_PATH = "casos/listarcasos";
  static String LIST_VISIT_PATH = "visita/listarvisitas";
  static String CREATE_VISIT_PATH = "visita/visita";
  static String CREATE_NOTICE_PATH = "noticia/criarnoticia";
  static String LIST_NOTICE_PATH = "noticia/listarnoticias";

  //Mensagens
  static const String registerCaseOption = "Registrar Caso";
  static const String sendMessageOption = "Enviar mensagem";
  static const String registerVisitOption = "Registrar Visita";
  static const String viewResidentsOption = "Ver Moradores";
}
