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
}
