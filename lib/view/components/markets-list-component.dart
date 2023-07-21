import 'package:flutter/material.dart';
import 'package:precobom/model/market.dart';
import 'package:precobom/service/market-service.dart';
import 'package:precobom/view/market-details-view.dart';

class MarketsList extends StatelessWidget {
  MarketsList({super.key, required this.searchString});

  MarketService service = MarketService();

  String searchString;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Market>>(
      future: service.getAllMarkets(),
      initialData: const [],
      builder: (context, snapshot) {
        List<Market>? markets;
        if (searchString.isNotEmpty) {
          markets = snapshot.data!
              .where(
                  (market) => market.name.toLowerCase().contains(searchString))
              .toList();
        } else {
          markets = snapshot.data;
        }
        debugPrint(markets.toString());
        if (markets!.isNotEmpty) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(1),
              itemCount: markets.length,
              itemBuilder: (context, i) {
                final Market market = markets![i];
                return buildMarketCard(market, context);
              });
        } else {
          return const Text("Não foram encontrados mercados.");
        }
      },
    );
  }
}

Widget buildMarketCard(Market market, BuildContext context) {
  return Card(
    color: const Color(0xFFFAF2F2),
    child: InkWell(
        onTap: () {
          debugPrint("click");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MarketDetailsView(
                    market: market,
                  )));
        },
        child: SizedBox(
          width: double.infinity,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(market.image),
            ),
            title: Text(
              market.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              market.address,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        )),
  );
}
