import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';

class ProductInfo extends StatelessWidget {
  final Product? product;

  const ProductInfo({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final item = product ?? products.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.category,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 2,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 18),
                const SizedBox(width: 4),
                Text(
                  item.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          item.formattedPrice,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: item.tags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              side: const BorderSide(color: Colors.black26),
              shape: const RoundedRectangleBorder(),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'ABOUT THIS PRODUCT',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          item.description,
          style: const TextStyle(fontSize: 14, height: 1.7),
        ),
      ],
    );
  }
}
