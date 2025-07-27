import 'package:nex_task/services/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController {
  AuthService authService = AuthService();

  Future<Map<String, dynamic>> createUser(
    String? email,
    String? password1,
    String? password2,
  ) async {
    if (email != null && password1 != null && password2 != null) {
      if (checkLowerCase(password1) &&
          checkUpperCase(password1) &&
          checkSpecialChars(password1) &&
          checkNumericalChars(password1)) {
        Map<String, dynamic> response = await authService.createUser(email, password1);
        if (response["session"] != null && response["user"] != null) {
          // TODO: REMOVE THIS PRINT
          print("RESPOSTA AO CRIAR USUARIO: $response");
          return response;
        } else {
          return {"session": "error", "user": "error"};
        }
      } else {
        return {"session": "error", "user": "error"};
      }
    } else {
      return {"session": "error", "user": "error"};
    }
  }

  Future<Map<String, dynamic>> login(String? email, String? password) async {
    if (email != null && password != null) {
      return await authService.login(email, password);
    } else {
      return {"session": "error", "user": "error"};
    }
  }
}

bool checkUpperCase(String password) {
  RegExp upperCaseChars = RegExp(r"[A-Z]");

  //TODO: REMOVER
  var resultado = upperCaseChars.hasMatch(password);
  print("TEM MAIUSCULA? $resultado");

  return upperCaseChars.hasMatch(password);
}

bool checkLowerCase(String password) {
  RegExp lowerCaseChars = RegExp(r"[a-z]");
  //TODO: REMOVER

  var resultado = lowerCaseChars.hasMatch(password);
  print("TEM MINUSCULA? $resultado");

  return lowerCaseChars.hasMatch(password);
}

bool checkSpecialChars(String password) {
  RegExp specialChars = RegExp(r"[!@€#£$‰&¶/÷()=?*±,-_;]");
  //TODO: REMOVER

  var resultado = specialChars.hasMatch(password);
  print("TEM ESPECIAL? $resultado");

  return specialChars.hasMatch(password);
}

bool checkNumericalChars(String password) {
  RegExp numericalChars = RegExp(r"[0-9]");

  //TODO: REMOVER
  var resultado = numericalChars.hasMatch(password);
  print("TEM NUMERO? $resultado");

  return numericalChars.hasMatch(password);
}
