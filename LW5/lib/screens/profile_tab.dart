import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../state/favorites_model.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String name = 'Guest';
  String email = '-';
  String role = '-';
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = SharedPreferencesAsync();
    final n = await prefs.getString('profile_name');
    final e = await prefs.getString('profile_email');
    final r = await prefs.getString('profile_role');
    if (!mounted) return;
    setState(() {
      name = n ?? name;
      email = e ?? email;
      role = r ?? role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 24),
        ListTile(leading: const Icon(Icons.email_outlined), title: Text(email)),
        ListTile(leading: const Icon(Icons.badge_outlined), title: Text(role)),
        const Divider(),
        SwitchListTile(
          title: const Text('Notifications'),
          value: notifications,
          activeThumbColor: Colors.black,
          onChanged: (v) => setState(() => notifications = v),
        ),
        ListenableBuilder(
          listenable: favorites,
          builder: (context, _) => ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: Text('Saved items: ${favorites.items.length}'),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: favorites.clear,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: const RoundedRectangleBorder(),
          ),
          child: const Text('Clear favorites'),
        ),
      ],
    );
  }
}
