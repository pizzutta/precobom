import 'package:flutter/material.dart';
import 'package:precobom/service/authentication-service.dart';
import 'package:precobom/view/login-view.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  AuthenticationService authenticationService = AuthenticationService();

  static const locationSwitchVal = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  authenticationService.logout().then((value) =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginView())));
                },
                child: const ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Sair"),
                ))
          ],
        ));
  }
}
