import 'package:flutter/material.dart';
import 'package:precobom/model/grocery-list.dart';
import 'package:precobom/service/grocery-list-service.dart';
import 'package:precobom/view/grocery-list-details-view.dart';

class GroceryListsView extends StatefulWidget {
  const GroceryListsView({Key? key}) : super(key: key);

  @override
  State<GroceryListsView> createState() => GroceryListsViewState();
}

class GroceryListsViewState extends State<GroceryListsView> {
  GroceryListService service = GroceryListService();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FutureBuilder<List<GroceryList>>(
          future: service.getGroceryListsByLoggedUser(),
          initialData: const [],
          builder: (context, snapshot) {
            List<GroceryList>? groceryLists = snapshot.data;

            if (groceryLists!.isNotEmpty) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(1),
                  itemCount: groceryLists.length,
                  itemBuilder: (context, i) {
                    final GroceryList groceryList = groceryLists[i];
                    return buildGroceryListCard(groceryList, context);
                  });
            } else {
              return const Center(child: Text("Não foram encontradas listas."));
            }
          })
    ]);
  }

  callback() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lista salva com sucesso!')),
      );
    });
  }

  Widget buildGroceryListCard(GroceryList groceryList, BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GroceryListDetailsView(groceryList: groceryList)));
          },
          child: ListTile(
            title: Text(
              groceryList.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: PopupMenuButton<int>(
              onSelected: (int value) {
                service.deleteGroceryListById(value).then((success) {
                  if (success) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Lista excluída com sucesso!')),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erro ao excluir lista.')),
                    );
                  }
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                PopupMenuItem<int>(
                  value: groceryList.id,
                  child: const Text('Excluir'),
                ),
              ],
            ),
          )),
    );
  }
}
