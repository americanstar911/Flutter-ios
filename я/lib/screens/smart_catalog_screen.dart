import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';

class SmartCatalogScreen extends StatefulWidget {
  const SmartCatalogScreen({super.key});

  @override
  State<SmartCatalogScreen> createState() => _SmartCatalogScreenState();
}

class _SmartCatalogScreenState extends State<SmartCatalogScreen> {
  late List<Product> items = List.of(products);
  bool isGrid = false;
  int refreshCount = 0;

  // Pull-to-Refresh: имитация запроса 1.5 с и новый товар в начало списка
  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    refreshCount++;
    final base = products[refreshCount % products.length];

    setState(() {
      items.insert(
        0,
        Product(
          id: 'new_$refreshCount',
          name: 'New Arrival $refreshCount',
          category: base.category,
          imagePath: base.imagePath,
          price: base.price + refreshCount * 10,
          rating: 4.0 + (refreshCount % 10) / 10,
          description: 'Freshly loaded item.',
          tags: const ['New'],
        ),
      );
    });
  }

  // Swipe-to-Delete + UNDO на прежний индекс
  void removeProduct(Product product) {
    final index = items.indexWhere((p) => p.id == product.id);
    if (index == -1) return;

    setState(() => items.removeAt(index));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('${product.name} removed'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              if (!mounted) return;
              setState(() {
                items.insert(
                  index > items.length ? items.length : index,
                  product,
                );
              });
            },
          ),
        ),
      );
  }

  void resetCatalog() {
    setState(() => items = List.of(products));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Catalog'),
        actions: [
          IconButton(
            tooltip: isGrid ? 'Show list' : 'Show grid',
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => isGrid = !isGrid),
          ),
        ],
      ),
      body: items.isEmpty ? _emptyState() : _content(context),
    );
  }

  Widget _content(BuildContext context) {
    // Мышь в Chrome тоже должна тянуть список, иначе pull-to-refresh не сработает
    final behavior = ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      },
    );

    return ScrollConfiguration(
      behavior: behavior,
      child: RefreshIndicator(
        onRefresh: refresh,
        color: Colors.black,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: isGrid ? _gridView() : _listView(),
          ),
        ),
      ),
    );
  }

  Widget _deleteBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
      child: Text(text, style: const TextStyle(fontSize: 10, letterSpacing: 1)),
    );
  }

  Widget _rating(double value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, size: 14),
        const SizedBox(width: 4),
        Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _listView() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final p = items[i];

        return Dismissible(
          key: ValueKey(p.id),
          direction: DismissDirection.endToStart,
          background: _deleteBackground(),
          onDismissed: (_) => removeProduct(p),
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: Icon(Icons.shopping_bag_outlined),
              ),
              title: Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    _tag(p.category),
                    const SizedBox(width: 8),
                    _rating(p.rating),
                  ],
                ),
              ),
              trailing: Text(p.formattedPrice),
            ),
          ),
        );
      },
    );
  }

  Widget _gridView() {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final p = items[i];

        return Dismissible(
          key: ValueKey(p.id),
          direction: DismissDirection.endToStart,
          background: _deleteBackground(),
          onDismissed: (_) => removeProduct(p),
          child: _gridCard(p),
        );
      },
    );
  }

  Widget _gridCard(Product p) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(p.imagePath, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                _tag(p.category),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _rating(p.rating),
                    const Spacer(),
                    Text(
                      p.formattedPrice,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inventory_2_outlined, size: 72),
          const SizedBox(height: 16),
          const Text(
            'Catalog is Empty',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: resetCatalog,
            child: const Text('Reset Catalog'),
          ),
        ],
      ),
    );
  }
}
