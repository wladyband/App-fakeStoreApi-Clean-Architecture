import 'package:fakestoreapi/app/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductData();
}