import 'package:flutter/material.dart';

import '../state/orders_model.dart';
import 'tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order history')),
      body: ListenableBuilder(
        listenable: orders,
        builder: (context, _) {
          final list = orders.orders;

          if (list.isEmpty) {
            return const Center(child: Text('No orders yet.'));
          }

          final now = DateTime.now();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final o in list)
                ExpansionTile(
                  title: Text('${o.id}  •  \$${o.total}'),
                  subtitle: Text('${o.dateLabel}  •  ${o.statusAt(now)}'),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    for (final l in o.lines)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${l.name} (size ${l.size}) x${l.quantity}',
                              ),
                            ),
                            Text('\$${l.price * l.quantity}'),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text('Delivery: ${o.delivery}'),
                    Text(
                      '${o.isPickup ? 'Pickup point' : 'Address'}: ${o.address}',
                    ),
                    if (o.contact.isNotEmpty) Text('Contact: ${o.contact}'),
                    if (o.discount > 0) Text('Points used: -\$${o.discount}'),
                    Text('Points earned: +${o.pointsEarned}'),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => TrackingScreen(order: o),
                        ),
                      ),
                      icon: const Icon(Icons.local_shipping_outlined),
                      label: const Text('Track order'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
