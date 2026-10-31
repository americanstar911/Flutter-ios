import 'package:flutter/material.dart';

import '../data/products.dart';
import '../widgets/product_grid.dart';

class FeedTab extends StatefulWidget {
  const FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  static const categories = ['TABI', 'REPLICA', 'FUTURE'];
  String selected = 'TABI';

  @override
  Widget build(BuildContext context) {
    final items = products.where((p) => p.category == selected).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: [
                  for (final c in categories)
                    ChoiceChip(
                      label: Text(c),
                      selected: selected == c,
                      showCheckmark: false,
                      backgroundColor: Colors.white,
                      selectedColor: Colors.black,
                      surfaceTintColor: Colors.transparent,
                      side: const BorderSide(color: Colors.black26),
                      shape: const RoundedRectangleBorder(),
                      labelStyle: TextStyle(
                        color: selected == c ? Colors.white : Colors.black,
                      ),
                      onSelected: (_) => setState(() => selected = c),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              ProductGrid(items: items),
            ],
          ),
        ),
      ),
    );
  }
}
