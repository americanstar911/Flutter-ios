import 'package:flutter/material.dart';
import 'profile_card_screen.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfileCardScreen(),
    );
  }
}