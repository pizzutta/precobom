import 'package:flutter/material.dart';
import 'package:precobom/model/product.dart';
import 'package:precobom/service/product-service.dart';
import 'package:precobom/view/product-details-view.dart';

import '../../model/order.dart';
import '../../utils.dart';

class ProductsList extends StatelessWidget {
  ProductsList({super.key, required this.searchString, required this.order});

  ProductService service = ProductService();

  String searchString;
  Order order;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: service.getAllProducts(order),
      initialData: const [],
      builder: (context, snapshot) {
        List<Product>? products;

        if (searchString.isNotEmpty) {
          products = snapshot.data!
              .where((product) =>
                  product.name.toLowerCase().contains(searchString))
              .toList();
        } else {
          products = snapshot.data;
        }

        if (products!.isNotEmpty) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(1),
              itemCount: products.length,
              itemBuilder: (context, i) {
                final Product product = products![i];
                return buildProductCard(product, context);
              });
        } else {
          return const Text("Não foram encontrados produtos.");
        }
      },
    );
  }
}

Widget buildProductCard(Product product, BuildContext context) {
  return Card(
    color: const Color(0xFFFAF2F2),
    child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsView(
                    product: product,
                  )));
        },
        child: SizedBox(
          width: double.infinity,
          child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: Image.asset(product.image),
                  )),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                formatCurrency(product.price),
                style: const TextStyle(fontSize: 16),
              )),
        )),
  );
}
