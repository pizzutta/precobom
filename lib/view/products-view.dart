import 'package:flutter/material.dart';
import 'package:precobom/model/order.dart';
import 'package:precobom/view/components/products-list-component.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  String searchString = "";
  Order? order = Order.byPriceAsc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 5, 0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                decoration: InputDecoration(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.72),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    hintText: "Buscar produtos"),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 20, 20, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.15, 60)),
                    maximumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width * 0.15, 60))),
                child: const Center(
                  child: Icon(
                    Icons.sort,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SizedBox(
                            height: 340,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: const Text("Ordenar por",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                ListTile(
                                  title: const Text("Menor preço"),
                                  leading: Radio<Order>(
                                    value: Order.byPriceAsc,
                                    groupValue: order,
                                    onChanged: (Order? value) {
                                      setState(() {
                                        order = value;
                                      });
                                      setModalState(() {
                                        order = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("Maior preço"),
                                  leading: Radio<Order>(
                                    value: Order.byPriceDesc,
                                    groupValue: order,
                                    onChanged: (Order? value) {
                                      setState(() {
                                        order = value;
                                      });
                                      setModalState(() {
                                        order = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("Nome (A - Z)"),
                                  leading: Radio<Order>(
                                    value: Order.byNameAsc,
                                    groupValue: order,
                                    onChanged: (Order? value) {
                                      setState(() {
                                        order = value;
                                      });
                                      setModalState(() {
                                        order = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("Nome (Z - A)"),
                                  leading: Radio<Order>(
                                    value: Order.byNameDesc,
                                    groupValue: order,
                                    onChanged: (Order? value) {
                                      setState(() {
                                        order = value;
                                      });
                                      setModalState(() {
                                        order = value;
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                            40),
                                        maximumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                            40),
                                      ),
                                      child: const Text("Fechar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                      });
                },
              ),
            ),
          ],
        ),
        Container(
            padding: const EdgeInsets.all(20),
            child: ProductsList(
              searchString: searchString,
              order: order!,
            ))
      ],
    );
  }
}
