import 'package:flutter/material.dart';
import 'package:precobom/service/grocery-list-service.dart';
import 'package:precobom/view/grocery-lists-view.dart';
import 'package:precobom/view/markets-view.dart';
import 'package:precobom/view/products-view.dart';
import 'package:precobom/view/settings-view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GroceryListService groceryListService = GroceryListService();

  final GlobalKey<GroceryListsViewState> key = GlobalKey();

  int currentPageIndex = 0;
  String title = "Produtos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: getFloatingActionButton(),
      backgroundColor: const Color(0xFFEBEBEB),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          switch (index) {
            case 0:
              title = "Produtos";
            case 1:
              title = "Mercados";
            case 2:
              title = "Listas";
            case 3:
              title = "Configurações";
          }
          setState(() {
            currentPageIndex = index;
          });
        },
        currentIndex: currentPageIndex,
        backgroundColor:
            const Color(0xFF780000) /*Theme.of(context).colorScheme.primary*/,
        selectedItemColor: const Color(0xFFEBEBEB),
        unselectedItemColor: const Color(0xFFEBEBEB),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket_outlined,
            ),
            label: "Produtos",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_grocery_store_outlined,
            ),
            label: "Mercados",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_bulleted,
              ),
              label: "Listas"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: "Configurações")
        ],
      ),
      body: SingleChildScrollView(
        child: <Widget>[
          const ProductsView(),
          const MarketsView(),
          GroceryListsView(key: key),
          Settings()
        ][currentPageIndex],
      ),
    );
  }

  Widget getFloatingActionButton() {
    if (currentPageIndex == 2) {
      final listNameController = TextEditingController();
      return FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Nova Lista"),
                  content: TextField(
                    controller: listNameController,
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.grey.shade800),
                        )),
                    TextButton(
                        onPressed: () =>
                            saveGroceryList(listNameController.text, context),
                        child: const Text("Salvar"))
                  ],
                )),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return Container();
    }
  }

  saveGroceryList(String name, BuildContext context) {
    groceryListService.saveGroceryList(name).then((success) {
      if (success) {
        key.currentState!.callback();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao salvar lista.')),
        );
      }
    });
  }
}
