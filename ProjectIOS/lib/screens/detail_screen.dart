import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/app_settings.dart';
import '../state/cart_model.dart';
import '../state/favorites_model.dart';
import '../widgets/cart_action_bar.dart';
import '../widgets/product_cover.dart';
import '../widgets/product_info.dart';
import 'cart_screen.dart';

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

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const sizes = ['36', '37', '38', '39', '40', '41', '42', '43', '44'];
  String? size;

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
                const Text(
                  'SELECT SIZE',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final s in sizes)
                      ChoiceChip(
                        label: Text(s),
                        selected: size == s,
                        showCheckmark: false,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        surfaceTintColor: Colors.transparent,
                        side: const BorderSide(color: Colors.black26),
                        shape: const RoundedRectangleBorder(),
                        labelStyle: TextStyle(
                          color: size == s ? Colors.white : Colors.black,
                        ),
                        onSelected: (_) => setState(() => size = s),
                      ),
                  ],
                ),
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
        onAddToCart: size == null
            ? null
            : () {
                cart.add(product, size!);
                if (!appSettings.notifications) return;
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      persist: false,
                      content: Text('${product.name} (size $size) added'),
                      action: SnackBarAction(
                        label: 'CART',
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => const CartScreen(),
                          ),
                        ),
                      ),
                    ),
                  );
              },
      ),
    );
  }
}
