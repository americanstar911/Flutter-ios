import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../state/favorites_model.dart';
import '../state/orders_model.dart';
import 'orders_screen.dart';
import '../state/app_settings.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String name = 'Guest';
  String email = '-';
  String role = '-';

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
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: orders,
          builder: (context, _) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'LOYALTY',
                      style: TextStyle(letterSpacing: 2, fontSize: 12),
                    ),
                    Text(
                      orders.levelName.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${orders.points} points',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: orders.progress,
                  minHeight: 6,
                  color: Colors.black,
                  backgroundColor: Colors.black12,
                ),
                const SizedBox(height: 8),
                Text(
                  orders.isMaxLevel
                      ? 'Highest level reached'
                      : '${orders.pointsToNext} points to ${orders.nextLevelName}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.receipt_long_outlined),
          title: const Text('Order history'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => const OrdersScreen()),
          ),
        ),
        const Divider(),
        ListenableBuilder(
          listenable: appSettings,
          builder: (context, _) => SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Pop-ups: added to cart, order status'),
            value: appSettings.notifications,
            activeThumbColor: Colors.black,
            onChanged: appSettings.setNotifications,
          ),
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
