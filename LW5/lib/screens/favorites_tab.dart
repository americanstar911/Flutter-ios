import 'package:flutter/material.dart';

import '../state/favorites_model.dart';
import '../widgets/product_grid.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: favorites,
      builder: (context, _) {
        final items = favorites.items;

        if (items.isEmpty) {
          return const Center(child: Text('No saved items yet.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Align(
                alignment: Alignment.topLeft,
                child: ProductGrid(items: items),
              ),
            ),
          ),
        );
      },
    );
  }
}
