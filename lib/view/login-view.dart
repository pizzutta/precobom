import 'package:flutter/material.dart';
import 'package:precobom/service/authentication-service.dart';
import 'package:precobom/view/home-view.dart';
import 'package:precobom/view/register-view.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final AuthenticationService service = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
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
              height: 90,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size.fromHeight(30),
                ),
                child: const Text('Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  login(emailController.text, passwordController.text, context);
                },
              )),
          /* TODO: Esqueceu a senha
            TextButton(
            onPressed: () {},
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline),
            ),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Não possui conta?",
                  style: TextStyle(color: Colors.grey[600])),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text("Cadastre-se",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline)))
            ],
          )
        ],
      ),
    )));
  }

  login(String email, String password, BuildContext context) {
    service.login(email, password).then((success) {
      if (success) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou Senha incorretos.')),
        );
      }
    });
  }
}
