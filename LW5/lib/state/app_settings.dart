import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  bool _notifications = true;
  bool _loaded = false;

  bool get notifications => _notifications;

  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      _notifications =
          await SharedPreferencesAsync().getBool('notifications') ?? true;
    } catch (_) {}
    notifyListeners();
  }

  Future<void> setNotifications(bool value) async {
    _notifications = value;
    notifyListeners();
    await SharedPreferencesAsync().setBool('notifications', value);
  }
}

final appSettings = AppSettings();
