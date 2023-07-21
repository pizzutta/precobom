import 'package:flutter/material.dart';
import 'package:precobom/model/grocery-list.dart';
import 'package:precobom/model/item-list.dart';
import 'package:precobom/model/product.dart';
import 'package:precobom/service/item-list-service.dart';
import 'package:precobom/utils.dart';
import 'package:precobom/view/product-details-view.dart';

class GroceryListDetailsView extends StatefulWidget {
  const GroceryListDetailsView({super.key, required this.groceryList});

  final GroceryList groceryList;

  @override
  State<GroceryListDetailsView> createState() => _GroceryListDetailsView();
}

class _GroceryListDetailsView extends State<GroceryListDetailsView> {
  ItemListService itemListService = ItemListService();

  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: const Color(0xFFEBEBEB),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 15, 10),
                  child: Text(widget.groceryList.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20))),
              const Divider(),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(1),
                  itemCount: widget.groceryList.items.length,
                  itemBuilder: (context, i) {
                    final ItemList itemList = widget.groceryList.items[i];
                    return ListTile(
                        title: Text(
                          itemList.product.name,
                          style: TextStyle(
                              decoration: itemList.checked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        leading: Checkbox(
                          value: itemList.checked,
                          onChanged: (bool? value) {
                            setState(() {
                              itemList.checked = value!;
                              itemListService.updateItemList(itemList);
                            });
                          },
                        ));
                  })
            ],
          ),
        ));
  }
}

Widget buildMarketProductCard(Product product, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsView(product: product)));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    product.image,
                    height: 60,
                  ),
                )),
          ),
        ),
        Text(
          product.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          formatCurrency(product.price),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}
