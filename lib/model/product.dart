import 'package:precobom/model/market.dart';

class Product {
  int id;
  String name;
  double price;
  String measuringUnit;
  String image;
  Market market;

  Product(this.id, this.name, this.price, this.measuringUnit, this.image,
      this.market);

  factory Product.fromJson(Map<String, dynamic> json) {
    var marketJson = json['market'];
    Market market = Market(marketJson['id'], marketJson['name'],
        marketJson['address'], marketJson['image']);
    return Product(json['id'], json['name'], json['price'],
        json['measuringUnit'], json['image'], market);
  }
}
