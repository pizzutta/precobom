import 'package:flutter/material.dart';
import 'package:precobom/model/product.dart';
import 'package:precobom/service/grocery-list-service.dart';
import 'package:precobom/view/market-details-view.dart';

import '../model/grocery-list.dart';
import '../service/item-list-service.dart';
import '../utils.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key, required this.product});

  GroceryListService groceryListService = GroceryListService();
  ItemListService itemListService = ItemListService();

  final Product product;

  @override
  Widget build(BuildContext context) {
    int? groceryListId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      backgroundColor: const Color(0xFFEBEBEB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4),
                child: Image.asset(product.image))
          ]),
          const Divider(),
          Container(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                product.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(children: [
                Text(
                  formatCurrency(product.price),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "/${product.measuringUnit}",
                  style: const TextStyle(fontSize: 16),
                ),
              ])),
          Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Card(
                color: const Color(0xFFFAF2F2),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MarketDetailsView(market: product.market)));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(product.market.image),
                        ),
                        title: Text(
                          product.market.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          product.market.address,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )),
              )),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 90,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: const Size.fromHeight(30),
                        ),
                        child: const Text('Adicionar à Lista',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                StatefulBuilder(builder: (context, setState) {
                                  return AlertDialog(
                                    title: const Text("Selecione a Lista"),
                                    content: SizedBox(
                                        width: double.maxFinite,
                                        child: FutureBuilder<List<GroceryList>>(
                                            future: groceryListService
                                                .getGroceryListsByLoggedUser(),
                                            initialData: const [],
                                            builder: (context, snapshot) {
                                              List<GroceryList>? groceryLists =
                                                  snapshot.data;

                                              if (groceryLists!.isNotEmpty) {
                                                return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    padding:
                                                        const EdgeInsets.all(1),
                                                    itemCount:
                                                        groceryLists.length,
                                                    itemBuilder: (context, i) {
                                                      final GroceryList
                                                          groceryList =
                                                          groceryLists[i];
                                                      return ListTile(
                                                        title: Text(
                                                            groceryList.name),
                                                        leading: Radio<int>(
                                                          value: groceryList.id,
                                                          groupValue:
                                                              groceryListId,
                                                          onChanged:
                                                              (int? value) {
                                                            setState(() {
                                                              groceryListId =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    });
                                              } else {
                                                return const Text(
                                                    "Não foram encontradas listas.");
                                              }
                                            })),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "Cancelar",
                                            style: TextStyle(
                                                color: Colors.grey.shade800),
                                          )),
                                      TextButton(
                                          onPressed: () => saveItemList(
                                              product.id,
                                              groceryListId,
                                              context),
                                          child: const Text("Salvar"))
                                    ],
                                  );
                                })),
                      ))))
        ],
      ),
    );
  }

  saveItemList(int productId, int? groceryListId, BuildContext context) {
    if (groceryListId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma lista.')),
      );
    } else {
      itemListService
          .saveItemList(productId, 1, false, groceryListId)
          .then((success) {
        if (success) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao adicionar item à lista.')),
          );
        }
      });
    }
  }
}
