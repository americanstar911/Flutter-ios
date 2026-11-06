import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/products.dart';
import '../models/product.dart';
import 'cart_provider.dart';
import 'cart_view_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = products.take(6).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, _) => IconButton(
              tooltip: 'Cart',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (_) => const CartViewScreen()),
              ),
              icon: Badge(
                isLabelVisible: cart.count > 0,
                label: Text('${cart.count}'),
                backgroundColor: Colors.black,
                textColor: Colors.white,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: catalog.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _ProductCard(product: catalog[i]),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final inCart = context.watch<CartProvider>().contains(product);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imagePath,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(product.formattedPrice),
                  const SizedBox(height: 12),
                  inCart
                      ? OutlinedButton.icon(
                          onPressed: () =>
                              context.read<CartProvider>().toggle(product),
                          icon: const Icon(Icons.remove_shopping_cart_outlined),
                          label: const Text('Remove'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(),
                          ),
                        )
                      : FilledButton.icon(
                          onPressed: () =>
                              context.read<CartProvider>().toggle(product),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Add to Cart'),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
