import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductController(this.productRepository);

  List<Product> productList = [];

  Future<void> updateProductList() async {
    productList = await productRepository.getProductData();
    notifyListeners();
  }
}
