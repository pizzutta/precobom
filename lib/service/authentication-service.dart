import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:precobom/dao/user-dao.dart';

import '../model/user.dart';

class AuthenticationService {
  final String API_REST = "http://10.0.2.2:8080";
  final UserDao dao = UserDao();

  Map<String, String> headers = <String, String>{
    "Content-type": "application/json",
  };

  Future<bool> login(String email, String password) async {
    final content = json.encode({"email": email, "password": password});

    final response = await http.post(Uri.parse("$API_REST/auth/login"),
        headers: headers, body: content);

    if (response.statusCode == 200) {
      User loggedUser = User.fromJson(jsonDecode(response.body));
      dao.save(loggedUser);
      return true;
    }
    return false;
  }

  Future<bool> register(
      String email, String password, String confirmationPassword) async {
    if (confirmationPassword.compareTo(password) != 0) {
      return false;
    }

    final content =
        json.encode({"email": email, "password": password, "role": "USER"});

    final response = await http.post(Uri.parse("$API_REST/auth/register"),
        headers: headers, body: content);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    dao.getLoggedUser().then((user) async {
      dao.delete(user!);
      return true;
    });
    return false;
  }
}
