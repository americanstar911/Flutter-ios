import 'package:flutter/material.dart';

import 'screens/product_screen.dart';

void main() {
  runApp(const Lab5App());
}

class Lab5App extends StatelessWidget {
  const Lab5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sneaker Store',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ProductScreen(),
    );
  }
}
