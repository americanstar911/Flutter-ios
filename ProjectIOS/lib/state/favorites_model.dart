import 'package:flutter/foundation.dart';

import '../data/products.dart';
import '../models/product.dart';

class FavoritesModel extends ChangeNotifier {
  final Set<String> _ids = {};

  bool isFavorite(Product p) => _ids.contains(p.id);

  List<Product> get items =>
      products.where((p) => _ids.contains(p.id)).toList();

  void toggle(Product p) {
    if (!_ids.remove(p.id)) _ids.add(p.id);
    notifyListeners();
  }

  void clear() {
    _ids.clear();
    notifyListeners();
  }
}

final favorites = FavoritesModel();
