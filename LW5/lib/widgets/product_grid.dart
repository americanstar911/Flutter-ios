import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/detail_screen.dart';
import '../state/favorites_model.dart';
import 'product_cover.dart';

/// Товары в ряд: 2 колонки на узком экране, 3 на широком.
class ProductGrid extends StatelessWidget {
  final List<Product> items;

  const ProductGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;

    return ListenableBuilder(
      listenable: favorites,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final columns = width < 600 ? 2 : 3;
            final cardWidth = (width - spacing * (columns - 1)) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final p in items)
                  SizedBox(
                    width: cardWidth,
                    child: ProductCard(
                      product: p,
                      isBookmarked: favorites.isFavorite(p),
                      onTap: () => openDetail(context, p),
                      onBookmarkPressed: () => favorites.toggle(p),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
