import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<int> _favoriteIds = [];
  List<int> get favoriteIds => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  void toggleFavorite(int productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favoriteIds.map((e) => e.toString()).toList());
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteStringList = prefs.getStringList('favorites');
    if (favoriteStringList != null) {
      _favoriteIds = favoriteStringList.map(int.parse).toList();
      notifyListeners();
    }
  }
}

