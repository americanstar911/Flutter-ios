import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';

class OrdersModel extends ChangeNotifier {
  static const levels = [('Bronze', 0), ('Silver', 100), ('Gold', 300)];

  final List<Order> _orders = [];
  int _points = 0;
  int _lifetime = 0;
  bool _loaded = false;

  List<Order> get orders => List.unmodifiable(_orders);
  int get points => _points;

  int get _levelIndex {
    var index = 0;
    for (var i = 0; i < levels.length; i++) {
      if (_lifetime >= levels[i].$2) index = i;
    }
    return index;
  }

  String get levelName => levels[_levelIndex].$1;
  bool get isMaxLevel => _levelIndex == levels.length - 1;
  String get nextLevelName => levels[_levelIndex + 1].$1;
  int get pointsToNext => levels[_levelIndex + 1].$2 - _lifetime;

  double get progress {
    if (isMaxLevel) return 1;
    final start = levels[_levelIndex].$2;
    final end = levels[_levelIndex + 1].$2;
    return (_lifetime - start) / (end - start);
  }

  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final prefs = SharedPreferencesAsync();
      _points = await prefs.getInt('loyalty_points') ?? 0;
      _lifetime = await prefs.getInt('loyalty_lifetime') ?? 0;
      final raw = await prefs.getString('orders_json');
      if (raw != null) {
        final list = jsonDecode(raw) as List<dynamic>;
        _orders
          ..clear()
          ..addAll(list.map((e) => Order.fromJson(e as Map<String, dynamic>)));
      }
    } catch (_) {
      // повреждённые данные игнорируем
    }
    notifyListeners();
  }

  Future<Order> place({
    required List<OrderLine> lines,
    required String delivery,
    required int deliveryPrice,
    required int pointsUsed,
    required int subtotal,
    required String address,
    required String contact,
    required bool isPickup,
    required DateTime eta,
  }) async {
    final total = subtotal + deliveryPrice - pointsUsed;
    final earned = (total * 0.05).floor();

    final order = Order(
      id: '#${1000 + _orders.length + 1}',
      date: DateTime.now(),
      lines: lines,
      delivery: delivery,
      deliveryPrice: deliveryPrice,
      discount: pointsUsed,
      total: total,
      pointsEarned: earned,
      address: address,
      contact: contact,
      isPickup: isPickup,
      eta: eta,
    );

    _orders.insert(0, order);
    _points = _points - pointsUsed + earned;
    _lifetime += earned;
    notifyListeners();

    final prefs = SharedPreferencesAsync();
    await prefs.setInt('loyalty_points', _points);
    await prefs.setInt('loyalty_lifetime', _lifetime);
    await prefs.setString(
      'orders_json',
      jsonEncode(_orders.map((o) => o.toJson()).toList()),
    );

    return order;
  }
}

final orders = OrdersModel();
