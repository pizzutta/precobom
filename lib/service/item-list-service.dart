import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:precobom/dao/user-dao.dart';
import 'package:precobom/model/grocery-list.dart';
import 'package:precobom/model/item-list.dart';

class ItemListService {
  final String API_REST = "http://10.0.2.2:8080";

  UserDao userDao = UserDao();

  Future<bool> saveItemList(
      int productId, int quantity, bool checked, int groceryListId) async {
    return userDao.getLoggedUser().then((user) async {
      final content = json.encode({
        "productId": productId,
        "quantity": quantity,
        "checked": checked,
        "groceryListId": groceryListId
      });

      String? token = "Bearer ${user!.token}";

      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response = await http.post(Uri.parse("$API_REST/item-list"),
          headers: headers, body: content);

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    });
  }

  Future<bool> updateItemList(ItemList itemList) async {
    return userDao.getLoggedUser().then((user) async {
      final content = json.encode({
        "id": itemList.id,
        "itemList": {
          "quantity": itemList.quantity,
          "checked": itemList.checked,
        }
      });

      String? token = "Bearer ${user!.token}";

      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response = await http.put(Uri.parse("$API_REST/item-list"),
          headers: headers, body: content);

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    });
  }

  Future<bool> deleteItemListById(int id) async {
    return userDao.getLoggedUser().then((user) async {
      final content = json.encode({"id": id});

      String? token = "Bearer ${user!.token}";

      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response = await http.delete(Uri.parse("$API_REST/item-list"),
          headers: headers, body: content);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    });
  }

  Future<List<GroceryList>> getGroceryListsByLoggedUser() async {
    return userDao.getLoggedUser().then((user) async {
      String? token = "Bearer ${user!.token}";

      Map<String, String> headers = <String, String>{
        "Content-type": "application/json",
        "Authorization": token
      };

      final response = await http.get(
          Uri.parse("$API_REST/grocery-list/user/${user.id}"),
          headers: headers);

      if (response.statusCode == 200) {
        Iterable result = jsonDecode(utf8.decode(response.bodyBytes));
        List<GroceryList> groceryLists =
            List.from(result.map((item) => GroceryList.fromJson(item)));

        return groceryLists;
      }
      return [];
    });
  }
}
