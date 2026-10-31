import 'package:flutter/material.dart';

import '../models/delivery.dart';
import '../models/order.dart';
import 'tracking_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Order order;

  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final where = order.isPickup
        ? 'Pickup: ${order.address}'
        : 'Deliver to: ${order.address}';
    final when = order.isPickup
        ? 'Ready by ${formatDay(order.eta)}'
        : 'Estimated arrival: ${formatDay(order.eta)}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order placed'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, size: 72),
                const SizedBox(height: 16),
                const Text(
                  'Thank you!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Text('Order ${order.id}'),
                Text('Total: \$${order.total}'),
                Text('Delivery: ${order.delivery}'),
                Text(where, textAlign: TextAlign.center),
                Text(when),
                const SizedBox(height: 8),
                Text('+${order.pointsEarned} loyalty points earned'),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => TrackingScreen(order: order),
                      ),
                    ),
                    icon: const Icon(Icons.local_shipping_outlined),
                    label: const Text('Track order'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text('Back to shop'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
