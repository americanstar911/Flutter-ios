import 'dart:async';

import 'package:flutter/material.dart';

import '../models/delivery.dart';
import '../models/order.dart';
import '../state/app_settings.dart';

class TrackingScreen extends StatefulWidget {
  final Order order;

  const TrackingScreen({super.key, required this.order});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  Timer? timer;
  late int lastStep = widget.order.stepAt(DateTime.now());

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final order = widget.order;
    final now = DateTime.now();
    final step = order.stepAt(now);

    if (step != lastStep) {
      lastStep = step;
      if (appSettings.notifications) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text('Order ${order.id}: ${order.steps[step]}'),
            ),
          );
      }
    }

    if (order.isFinishedAt(now)) timer?.cancel();
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final now = DateTime.now();
    final current = order.stepAt(now);
    final finished = order.isFinishedAt(now);

    return Scaffold(
      appBar: AppBar(title: const Text('Tracking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ${order.id}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(order.steps[current].toUpperCase()),
                const SizedBox(height: 4),
                Text(
                  order.isPickup
                      ? 'Ready by ${formatDay(order.eta)}'
                      : 'Estimated arrival: ${formatDay(order.eta)}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                for (var i = 0; i < order.steps.length; i++)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(
                            (i < current || (finished && i == current))
                                ? Icons.check_circle
                                : i == current
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: i <= current ? Colors.black : Colors.black26,
                          ),
                          if (i < order.steps.length - 1)
                            Container(
                              width: 2,
                              height: 32,
                              color: i < current
                                  ? Colors.black
                                  : Colors.black12,
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          order.steps[i],
                          style: TextStyle(
                            fontWeight: i == current
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: i <= current ? Colors.black : Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                const Divider(height: 32),
                Text('Delivery: ${order.delivery}'),
                const SizedBox(height: 4),
                Text(
                  '${order.isPickup ? 'Pickup point' : 'Address'}: ${order.address}',
                ),
                if (order.contact.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text('Contact: ${order.contact}'),
                ],
                const SizedBox(height: 4),
                Text('Total: \$${order.total}'),
                const SizedBox(height: 16),
                Text(
                  'Demo mode: the status advances every '
                  '${Order.stepSeconds} seconds.',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
