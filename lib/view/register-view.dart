import 'dart:async';

import 'package:flutter/material.dart';

import '../service/authentication-service.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final AuthenticationService service = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmationPasswordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                  child: Image.asset("assets/img/precobom.png")),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'E-mail',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Senha',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: confirmationPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Confirmar senha',
                  ),
                ),
              ),
              Container(
                  height: 90,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: const Size.fromHeight(30),
                    ),
                    child: const Text('Cadastrar',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () {
                      register(emailController.text, passwordController.text,
                          confirmationPasswordController.text, context);
                    },
                  )),
            ],
          ),
        )));
  }

  register(String email, String password, String confirmationPassword,
      BuildContext context) {
    service.register(email, password, confirmationPassword).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastrado com sucesso!')),
        );
        Timer(const Duration(seconds: 1), () => Navigator.of(context).pop());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao cadastrar-se.')),
        );
      }
    });
  }
}
