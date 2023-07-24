import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/domain/models/product.dart';

class ProductAPI {
  final Http _http;

  ProductAPI(this._http);

  Future<List<Product>> getProductIdUser() async {
    final result = await _http.request(
      '/products',
      onSuccess: (json) {
        if (json is List<dynamic>) {
          List<Map<String, dynamic>> productsJson = json.cast<Map<String, dynamic>>();
          List<Product> products = Product.fromJsonList(productsJson);
          return products;
        } else {
          throw Exception('Erro na conversão dos dados da API');
        }
      },
    );

    return result.when(
      left: (_) => throw Exception('Erro na requisição HTTP'),
      right: (products) => products,
    );
  }


}
