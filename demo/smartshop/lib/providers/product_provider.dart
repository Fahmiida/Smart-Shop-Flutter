import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

enum SortOption { priceLowToHigh, priceHighToLow, rating }

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => [..._products];

  bool _loading = false;
  bool get loading => _loading;

  SortOption _sortOption = SortOption.priceLowToHigh;
  SortOption get sortOption => _sortOption;

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();

    final url = Uri.parse('https://fakestoreapi.com/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _products = jsonData.map((item) => Product.fromJson(item)).toList();
        sortProducts(_sortOption);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void sortProducts(SortOption option) {
    _sortOption = option;
    if (option == SortOption.priceLowToHigh) {
      _products.sort((a, b) => a.price.compareTo(b.price));
    } else if (option == SortOption.priceHighToLow) {
      _products.sort((a, b) => b.price.compareTo(a.price));
    } else if (option == SortOption.rating) {
      _products.sort((a, b) => b.rating.compareTo(a.rating));
    }
    notifyListeners();
  }
}


