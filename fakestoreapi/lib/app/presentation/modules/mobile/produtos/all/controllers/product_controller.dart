import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository productRepository;
  List<Product> productList = [];
  List<String> favoriteProducts = [];
  String searchTerm = '';
  bool _isMounted = false;
  bool _noResultsFound = false;

  Map<String, Product> productMap = {};



  void init() {
    _isMounted = true;
  }

  void dispose() {
    _isMounted = false;
  }

  void updateSearchTerm(String value) {
    searchTerm = value;
    notifyListeners();
  }

  ProductController(this.productRepository) {

    loadFavoriteProducts();
  }

  bool isLoading() {
    return productList.isEmpty;
  }

  Future<void> updateProductList() async {
    productList = await productRepository.getProductData();
    notifyListeners();
  }

  List<Product> getFilteredProducts() {
    List<Product> products = productList;
    List<Product> filteredProducts = products.where((product) {
      final title = product.title.toLowerCase();
      final searchLowercase = searchTerm.toLowerCase();
      return title.contains(searchLowercase);
    }).toList();

    return filteredProducts;
  }


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
