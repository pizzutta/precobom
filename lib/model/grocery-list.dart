import 'package:precobom/model/item-list.dart';
import 'package:precobom/model/product.dart';
import 'package:precobom/model/user.dart';

class GroceryList {
  int id;
  String name;
  User user;
  List<ItemList> items = [];

  GroceryList(this.id, this.name, this.user, this.items);

  factory GroceryList.fromJson(Map<String, dynamic> json) {
    var userJson = json['user'];
    User user = User(userJson['id'], userJson['email'], userJson['role'], "");

    List<ItemList> items = List.generate(json['items'].length, (index) {
      var itemJson = json['items'][index];
      var productJson = itemJson['product'];
      Product product = Product.fromJson(productJson);
      return ItemList(
          itemJson['id'], product, itemJson['quantity'], itemJson['checked']);
    });

    return GroceryList(json['id'], json['name'], user, items);
  }
}
