import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:precobom/dao/user-dao.dart';
import 'package:precobom/model/market.dart';

class MarketService {
  final String API_REST = "http://10.0.2.2:8080";

  UserDao userDao = UserDao();

  Future<List<Market>> getAllMarkets() async {
    return userDao.getLoggedUser().then((user) async {
      String? token = "Bearer ${user!.token}";

      debugPrint(token);
      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response =
          await http.get(Uri.parse("$API_REST/market"), headers: headers);

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        Iterable result = jsonDecode(utf8.decode(response.bodyBytes));
        List<Market> markets =
            List.from(result.map((item) => Market.fromJson(item)));

        return markets;
      }
      return [];
    });
  }
}
