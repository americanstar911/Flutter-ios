import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/delivery.dart';
import '../models/order.dart';
import '../state/cart_model.dart';
import '../state/orders_model.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final aptCtrl = TextEditingController();

  int methodIndex = 0;
  int pickupPointIndex = 0;
  bool usePoints = false;
  bool saveDetails = true;
  bool placing = false;

  DeliveryMethod get method => deliveryMethods[methodIndex];
  int get deliveryPrice => method.priceFor(cart.subtotal);
  int get pointsUsed => usePoints ? math.min(orders.points, cart.subtotal) : 0;
  int get total => cart.subtotal + deliveryPrice - pointsUsed;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = SharedPreferencesAsync();
    final name =
        await prefs.getString('addr_name') ??
        await prefs.getString('profile_name');
    final phone = await prefs.getString('addr_phone');
    final city = await prefs.getString('addr_city');
    final street = await prefs.getString('addr_street');
    final apt = await prefs.getString('addr_apt');
    if (!mounted) return;
    nameCtrl.text = name ?? '';
    phoneCtrl.text = phone ?? '';
    cityCtrl.text = city ?? '';
    streetCtrl.text = street ?? '';
    aptCtrl.text = apt ?? '';
  }

  Future<void> _saveDetails() async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString('addr_name', nameCtrl.text.trim());
    await prefs.setString('addr_phone', phoneCtrl.text.trim());
    if (!method.isPickup) {
      await prefs.setString('addr_city', cityCtrl.text.trim());
      await prefs.setString('addr_street', streetCtrl.text.trim());
      await prefs.setString('addr_apt', aptCtrl.text.trim());
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    streetCtrl.dispose();
    aptCtrl.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => placing = true);

    final m = method;
    final apt = aptCtrl.text.trim();
    final addressText = m.isPickup
        ? pickupPoints[pickupPointIndex]
        : [
            cityCtrl.text.trim(),
            streetCtrl.text.trim(),
            if (apt.isNotEmpty) apt,
          ].join(', ');

    if (saveDetails) await _saveDetails();

    final lines = [
      for (final i in cart.items)
        OrderLine(
          name: i.product.name,
          size: i.size,
          quantity: i.quantity,
          price: i.product.price,
        ),
    ];

    final order = await orders.place(
      lines: lines,
      delivery: m.name,
      deliveryPrice: deliveryPrice,
      pointsUsed: pointsUsed,
      subtotal: cart.subtotal,
      address: addressText,
      contact: '${nameCtrl.text.trim()}, ${phoneCtrl.text.trim()}',
      isPickup: m.isPickup,
      eta: DateTime.now().add(Duration(days: m.maxDays)),
    );
    cart.clear();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => OrderSuccessScreen(order: order)),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    String? Function(String?)? validator,
    TextInputType? type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
        ),
        validator: validator,
      ),
    );
  }

  String? Function(String?) _minLength(int n, String message) {
    return (v) => (v == null || v.trim().length < n) ? message : null;
  }

  Widget _row(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      fontSize: bold ? 18 : 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = method;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title('DELIVERY METHOD'),
                  for (var i = 0; i < deliveryMethods.length; i++)
                    _ChoiceTile(
                      selected: methodIndex == i,
                      title: deliveryMethods[i].name,
                      subtitle: deliveryMethods[i].freeOverThreshold
                          ? '${deliveryMethods[i].etaLabel()} · free over \$$freeDeliveryFrom'
                          : deliveryMethods[i].etaLabel(),
                      trailing: deliveryMethods[i].priceFor(cart.subtotal) == 0
                          ? 'Free'
                          : '\$${deliveryMethods[i].priceFor(cart.subtotal)}',
                      onTap: () => setState(() => methodIndex = i),
                    ),
                  const SizedBox(height: 16),
                  if (m.isPickup) ...[
                    _title('PICKUP POINT'),
                    for (var i = 0; i < pickupPoints.length; i++)
                      _ChoiceTile(
                        selected: pickupPointIndex == i,
                        title: pickupPoints[i],
                        subtitle: 'Open daily 10:00-20:00',
                        onTap: () => setState(() => pickupPointIndex = i),
                      ),
                  ] else ...[
                    _title('ADDRESS'),
                    _field(
                      cityCtrl,
                      'City',
                      validator: _minLength(2, 'Enter a city'),
                    ),
                    _field(
                      streetCtrl,
                      'Street and house',
                      validator: _minLength(3, 'Enter a street and house'),
                    ),
                    _field(aptCtrl, 'Apartment / office (optional)'),
                  ],
                  const SizedBox(height: 8),
                  _title('CONTACT'),
                  _field(
                    nameCtrl,
                    'Recipient name',
                    validator: _minLength(2, 'Enter a name'),
                  ),
                  _field(
                    phoneCtrl,
                    'Phone',
                    type: TextInputType.phone,
                    validator: (v) {
                      final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                      return digits.length < 10
                          ? 'Enter a valid phone number'
                          : null;
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Save details for next time'),
                    value: saveDetails,
                    activeThumbColor: Colors.black,
                    onChanged: (v) => setState(() => saveDetails = v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Use loyalty points (${orders.points})'),
                    subtitle: const Text('1 point = \$1 discount'),
                    value: usePoints,
                    activeThumbColor: Colors.black,
                    onChanged: orders.points == 0
                        ? null
                        : (v) => setState(() => usePoints = v),
                  ),
                  const Divider(height: 32),
                  _row('Subtotal', '\$${cart.subtotal}'),
                  _row(
                    'Delivery',
                    deliveryPrice == 0 ? 'Free' : '\$$deliveryPrice',
                  ),
                  if (pointsUsed > 0) _row('Points', '-\$$pointsUsed'),
                  _row('Total', '\$$total', bold: true),
                  const SizedBox(height: 4),
                  Text(
                    '${m.etaLabel()}  ·  you will earn '
                    '${(total * 0.05).floor()} points',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: placing ? null : submit,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(placing ? 'Placing order...' : 'Place order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final bool selected;
  final String title;
  final String subtitle;
  final String? trailing;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.black : Colors.black26,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) Text(trailing!),
            ],
          ),
        ),
      ),
    );
  }
}
