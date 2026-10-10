import 'package:flutter/material.dart';

class CartActionBar extends StatelessWidget {
  final VoidCallback onAddToCart;

  const CartActionBar({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: onAddToCart,
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to Cart'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
