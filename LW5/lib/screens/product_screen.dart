import 'package:flutter/material.dart';

import '../widgets/product_cover.dart';
import '../widgets/product_info.dart';
import '../widgets/cart_action_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isBookmarked = false;
  int _cartCount = 0;

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _addToCart() {
    setState(() {
      _cartCount++;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Product added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCover(
                      isBookmarked: _isBookmarked,
                      onBookmarkPressed: _toggleBookmark,
                    ),
                    const SizedBox(height: 20),
                    const ProductInfo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CartActionBar(
        cartCount: _cartCount,
        onAddToCart: _addToCart,
      ),
    );
  }
}
