import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, Product> _items = {};

  Map<int, Product> get items => {..._items};

  int get itemCount => _items.length;

  double get totalPrice => _items.values.fold(0, (sum, item) => sum + item.price);

  void addItem(Product product) {
    _items[product.id] = product;
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
