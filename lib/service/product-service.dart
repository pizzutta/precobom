import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:precobom/dao/user-dao.dart';
import 'package:precobom/model/order.dart';
import 'package:precobom/model/product.dart';

class ProductService {
  final String API_REST = "http://10.0.2.2:8080";

  UserDao userDao = UserDao();

  Future<List<Product>> getAllProducts(Order order) async {
    return userDao.getLoggedUser().then((user) async {
      String? token = "Bearer ${user!.token}";

      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response = await http.get(
          Uri.parse(
              "$API_REST/product?order={\"property\": \"${order.property}\", \"direction\": \"${order.direction}\"}"),
          headers: headers);

      if (response.statusCode == 200) {
        Iterable result = jsonDecode(utf8.decode(response.bodyBytes));
        List<Product> products =
            List.from(result.map((item) => Product.fromJson(item)));

        return products;
      }
      return [];
    });
  }

  Future<List<Product>> getProductsByMarketId(int marketId) async {
    return userDao.getLoggedUser().then((user) async {
      String? token = "Bearer ${user!.token}";

      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response = await http.get(
          Uri.parse("$API_REST/product/market/$marketId"),
          headers: headers);

      if (response.statusCode == 200) {
        Iterable result = jsonDecode(utf8.decode(response.bodyBytes));
        List<Product> products =
            List.from(result.map((item) => Product.fromJson(item)));

        return products;
      }
      return [];
    });
  }
}
