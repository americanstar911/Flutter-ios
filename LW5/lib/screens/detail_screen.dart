import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/favorites_model.dart';
import '../widgets/cart_action_bar.dart';
import '../widgets/product_cover.dart';
import '../widgets/product_info.dart';

/// Navigator.push с передачей целого объекта через arguments.
void openDetail(BuildContext context, Product product) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      settings: RouteSettings(name: '/detail', arguments: product),
      builder: (_) => const DetailScreen(),
    ),
  );
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListenableBuilder(
                  listenable: favorites,
                  builder: (context, _) => ProductCover(
                    imagePath: product.imagePath,
                    isBookmarked: favorites.isFavorite(product),
                    onBookmarkPressed: () => favorites.toggle(product),
                  ),
                ),
                const SizedBox(height: 20),
                ProductInfo(product: product),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to list'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CartActionBar(
        onAddToCart: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You selected ${product.name}')),
          );
        },
      ),
    );
  }
}
