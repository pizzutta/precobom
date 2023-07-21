import 'package:flutter/material.dart';
import 'package:precobom/view/login-view.dart';

void main() {
  runApp(const MaterialApp(
    home: PrecoBom(),
  ));
}

class PrecoBom extends StatelessWidget {
  const PrecoBom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preço Bom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF780000),
            primary: const Color(0xFF780000),
            secondary: const Color(0xFF003049)),
        useMaterial3: true,
      ),
      home: LoginView(),
    );
  }
}
