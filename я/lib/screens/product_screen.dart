import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../widgets/cart_action_bar.dart';
import '../widgets/product_cover.dart';
import '../widgets/product_info.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _selectedCategory = 'TABI';
  bool _showBookmarks = false;
  final Set<String> _bookmarks = {};

  void _toggleBookmark(String productId) {
    setState(() {
      if (_bookmarks.contains(productId)) {
        _bookmarks.remove(productId);
      } else {
        _bookmarks.add(productId);
      }
    });
  }

  void _openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ProductScreen(
          product: product,
          isBookmarked: _bookmarks.contains(product.id),
          onBookmarkPressed: () => _toggleBookmark(product.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const categories = ['TABI', 'REPLICA', 'FUTURE'];

    const subtitles = {
      'TABI': 'CLASSIC',
      'REPLICA': 'COMFORT',
      'FUTURE': 'EXPERIMENTAL',
    };

    final visibleProducts = products.where((product) {
      final matchesCategory = product.category == _selectedCategory;
      final matchesBookmark =
          !_showBookmarks || _bookmarks.contains(product.id);

      return matchesCategory && matchesBookmark;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Maison Margiela'),
        ),
        actions: [
          IconButton(
            tooltip: _showBookmarks
                ? 'Show all products'
                : 'Show bookmarked products',
            onPressed: () {
              setState(() {
                _showBookmarks = !_showBookmarks;
              });
            },
            icon: Icon(_showBookmarks ? Icons.bookmark : Icons.bookmark_border),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MEN / FOOTWEAR COLLECTION',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 1,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories.map((category) {
                        final selected = _selectedCategory == category;

                        return ChoiceChip(
                          selected: selected,
                          showCheckmark: false,
                          backgroundColor: Colors.white,
                          selectedColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          shape: const RoundedRectangleBorder(),
                          label: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: selected ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitles[category]!,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: selected
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedCategory,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${visibleProducts.length} ITEMS',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (visibleProducts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'No bookmarked products in this section.',
                          style: TextStyle(height: 1.6),
                        ),
                      )
                    else
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final columns = constraints.maxWidth >= 700
                              ? 3
                              : constraints.maxWidth >= 320
                              ? 2
                              : 1;

                          const spacing = 12.0;

                          final cardWidth =
                              (constraints.maxWidth - spacing * (columns - 1)) /
                              columns;

                          return Wrap(
                            spacing: spacing,
                            runSpacing: 24,
                            children: visibleProducts.map((product) {
                              return SizedBox(
                                width: cardWidth,
                                child: ProductCard(
                                  product: product,
                                  isBookmarked: _bookmarks.contains(product.id),
                                  onTap: () => _openProduct(product),
                                  onBookmarkPressed: () {
                                    _toggleBookmark(product.id);
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductScreen extends StatefulWidget {
  final Product product;
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;

  const ProductScreen({
    super.key,
    required this.product,
    required this.isBookmarked,
    required this.onBookmarkPressed,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  void _toggleBookmark() {
    widget.onBookmarkPressed();

    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _addToCart() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('You selected ${widget.product.name}')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Maison Margiela'),
        ),
      ),
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
                      imagePath: widget.product.imagePath,
                      isBookmarked: _isBookmarked,
                      onBookmarkPressed: _toggleBookmark,
                    ),
                    const SizedBox(height: 24),
                    ProductInfo(product: widget.product),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CartActionBar(onAddToCart: _addToCart),
    );
  }
}
