import 'package:flutter/material.dart';
import 'package:precobom/view/components/markets-list-component.dart';

class MarketsView extends StatefulWidget {
  const MarketsView({Key? key}) : super(key: key);

  @override
  State<MarketsView> createState() => _MarketsViewState();
}

class _MarketsViewState extends State<MarketsView> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                hintText: "Buscar mercados"),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(20),
            child: MarketsList(
              searchString: searchString,
            ))
      ],
    );
  }
}
