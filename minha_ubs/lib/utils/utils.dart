import 'dart:convert';

class Utils {
  static int getCaseId(String? caseString) {
    switch (caseString) {
      case "SINTOMAS GRIPAIS":
        return 1;
      case "SINTOMAS DE DENGUE":
        return 2;
      case "HIPERTENSÃO":
        return 3;
      case "DIABETES":
        return 4;
      case "OBESIDADE":
        return 5;
      case "DESNUTRIÇÃO":
        return 6;
      default:
        return 0;
    }
  }

  static String buildRegisterNoticeBody(int BHUId, int agentId, String notice) {
    Map registerNoticeBody = {
      "posto": "$BHUId",
      "agente": "$agentId",
      "noticia": notice,
    };

    return const JsonEncoder().convert(registerNoticeBody);
  }

  static String buildRegisterCaseBody(
      int BHUId, int agentId, int personId, int caseId) {
    Map registerCaseBody = {
      "posto": BHUId.toString(),
      "agente": agentId.toString(),
      "pessoa": personId.toString(),
      "caso": caseId.toString(),
    };

    return JsonEncoder().convert(registerCaseBody);
  }

  static String buildVisitBody(String BHUId, String agentId, String familyId) {
    Map visitBody = {
      "posto": BHUId,
      "agente": agentId,
      "familia": familyId,
    };

    return JsonEncoder().convert(visitBody);
  }

  static String buildListCaseBody(String BHUId, String agentId, String caseId,
      String startDate, String endDate) {
    Map visitBody = {
      "posto": BHUId,
      "agente": agentId,
      "caso": caseId,
      "dataInicio": startDate,
      "dataFim": endDate
    };

    return JsonEncoder().convert(visitBody);
  }
}
