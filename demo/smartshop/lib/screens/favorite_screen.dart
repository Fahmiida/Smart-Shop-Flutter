import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final favoriteProducts = productProvider.products
        .where((p) => favoriteProvider.favoriteIds.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No favorites added'))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          final inCart = cartProvider.items.containsKey(product.id);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: ListTile(
              leading: Image.network(product.image, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  RatingBarIndicator(
                    rating: product.rating,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 16,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(inCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart),
                onPressed: () {
                  if (inCart) {
                    cartProvider.removeItem(product.id);
                  } else {
                    cartProvider.addItem(product);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

