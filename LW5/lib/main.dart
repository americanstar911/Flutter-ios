import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/product_screen.dart';
import 'screens/registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = SharedPreferencesAsync();
  final isRegistered =
      await preferences.getBool('registration_complete') ?? false;

  runApp(Lab5App(isRegistered: isRegistered));
}

class Lab5App extends StatelessWidget {
  final bool isRegistered;

  const Lab5App({super.key, this.isRegistered = false});

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
      home: isRegistered
          ? const CatalogScreen()
          : Builder(
              builder: (context) {
                return RegistrationScreen(
                  onRegistered: (name, email, role) async {
                    final preferences = SharedPreferencesAsync();

                    await preferences.setString('profile_name', name);
                    await preferences.setString('profile_email', email);
                    await preferences.setString('profile_role', role);
                    await preferences.setBool('registration_complete', true);

                    if (!context.mounted) return;

                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) {
                        return AlertDialog(
                          scrollable: true,
                          title: const Text('Registration successful!'),
                          content: Text(
                            'Your profile has been saved.\n\n'
                            'Full Name: $name\n'
                            'Email: $email\n'
                            'Role: $role',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: const Text('Continue'),
                            ),
                          ],
                        );
                      },
                    );

                    if (!context.mounted) return;

                    Navigator.of(context).pushAndRemoveUntil<void>(
                      MaterialPageRoute<void>(
                        builder: (context) => const CatalogScreen(),
                      ),
                      (route) => false,
                    );
                  },
                );
              },
            ),
    );
  }
}
