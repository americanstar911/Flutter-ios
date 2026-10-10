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
      title: 'Maison Margiela',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'RobotoMono',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black).copyWith(
          primary: Colors.black,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'CormorantGaramond',
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
          ),
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}
