import 'package:flutter/material.dart';
import 'package:precobom/model/product.dart';
import 'package:precobom/service/product-service.dart';
import 'package:precobom/utils.dart';
import 'package:precobom/view/product-details-view.dart';

import '../model/market.dart';

class MarketDetailsView extends StatefulWidget {
  const MarketDetailsView({super.key, required this.market});

  final Market market;

  @override
  State<MarketDetailsView> createState() => _MarketDetailsViewState();
}

class _MarketDetailsViewState extends State<MarketDetailsView> {
  ProductService productService = ProductService();

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
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.market.image,
                        height: 100,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.market.name,
                              softWrap: true,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text(
                              widget.market.address,
                              softWrap: true,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ))
                  ])),
              const Divider(),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchString = value;
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      hintText: "Buscar produtos"),
                ),
              ),
              Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.63),
                  child: CustomScrollView(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[
                      FutureBuilder<List<Product>>(
                          future: productService
                              .getProductsByMarketId(widget.market.id),
                          initialData: const [],
                          builder: (context, snapshot) {
                            List<Product>? products;
                            if (searchString.isNotEmpty) {
                              products = snapshot.data!
                                  .where((product) => product.name
                                      .toLowerCase()
                                      .contains(searchString))
                                  .toList();
                            } else {
                              products = snapshot.data;
                            }
                            if (products!.isNotEmpty) {
                              return SliverPadding(
                                  padding: const EdgeInsets.all(20),
                                  sliver: SliverGrid.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio:
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          1.4)),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemCount: products.length,
                                      itemBuilder: (context, i) {
                                        final Product product = products![i];
                                        return buildMarketProductCard(
                                            product, context);
                                      }));
                            } else {
                              return const SliverToBoxAdapter(
                                  child: Text(
                                      "Não foram encontrados produtos para este mercado."));
                            }
                          }),
                    ],
                  ))
            ],
          ),
        ));
  }
}

Widget buildMarketProductCard(Product product, BuildContext context) {
  return InkWell(
    onTap: () {
      debugPrint("click");
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
