import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Nike Sneakers',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 22),
                SizedBox(width: 4),
                Text('4.8', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          '59 990 ₸',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: Text('Sneakers')),
            Chip(label: Text('Sport')),
            Chip(label: Text('Everyday')),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'About this product',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Lightweight sneakers for everyday activities. '
          'A comfortable fit and a simple sporty design.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }
}
