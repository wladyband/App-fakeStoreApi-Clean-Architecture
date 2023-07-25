import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository productRepository;
  List<Product> productList = [];
  List<String> favoriteProducts = [];
  String _searchTerm = '';
  bool _isMounted = false;

  void init() {
    _isMounted = true;
  }

  void dispose() {
    _isMounted = false;
  }

  ProductController(this.productRepository) {
    // Ao criar a instância do ProductController, carregar os produtos favoritados do SharedPreferences
    loadFavoriteProducts();
  }

  Future<void> updateProductList() async {
    productList = await productRepository.getProductData();
    notifyListeners();
  }

  // Carregar os produtos favoritados do SharedPreferences
  Future<void> loadFavoriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteProducts = prefs.getStringList('favoriteProducts') ?? [];
    notifyListeners();
  }

  // Método para verificar se o produto é um favorito
  bool isFavorite(Product product) {
    return favoriteProducts.contains(product.id.toString());
  }

  // Método para salvar ou remover o produto dos favoritos
  void toggleFavorite(Product product) async {
    String productId = product.id.toString();
    if (isFavorite(product)) {
      favoriteProducts.remove(productId);
    } else {
      favoriteProducts.add(productId);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteProducts', favoriteProducts);
    notifyListeners();
  }
}
