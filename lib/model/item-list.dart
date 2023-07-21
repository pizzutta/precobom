import 'package:precobom/model/product.dart';

class ItemList {
  int id;
  Product product;
  int quantity;
  bool checked;

  ItemList(this.id, this.product, this.quantity, this.checked);
}
