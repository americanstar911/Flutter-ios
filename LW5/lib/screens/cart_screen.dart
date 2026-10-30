import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/delivery.dart';
import '../state/cart_model.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          if (cart.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final remaining = freeDeliveryFrom - cart.subtotal;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, _) => const Divider(height: 24),
                  itemBuilder: (context, i) => _CartRow(item: cart.items[i]),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        remaining > 0
                            ? 'Add \$$remaining more for free courier delivery'
                            : 'Free courier delivery unlocked',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: math.min(1.0, cart.subtotal / freeDeliveryFrom),
                        minHeight: 4,
                        color: Colors.black,
                        backgroundColor: Colors.black12,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text(
                            '\$${cart.subtotal}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.local_shipping_outlined),
                          label: const Text('Continue to delivery'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CartRow extends StatelessWidget {
  final CartItem item;

  const _CartRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          item.product.imagePath,
          width: 64,
          height: 96,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text('Size ${item.size}', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text('\$${item.total}'),
              const SizedBox(height: 4),
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Decrease',
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => cart.decrement(item),
                  ),
                  Text('${item.quantity}'),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Increase',
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => cart.increment(item),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Remove',
          icon: const Icon(Icons.close),
          onPressed: () => cart.remove(item),
        ),
      ],
    );
  }
}
