


import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/domain/models/product.dart';

class ProductAPI {
  final Http _http;

  ProductAPI(this._http);

  Future<List<Product>> getProductIdUser() async {
    final result = await _http.request(
      '/products',
     onSuccess: (json) {
        List<Map<String, dynamic>> productsJson = json;
        List<Product> products = Product.fromJsonList(productsJson);
        return products;
      },
    );

    return result.when(
      left: (_) => [],
      right: (products) => products,
    );
  }
}