import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:fakestoreapi/app/data/repositories_implementation/product_repository_impl.dart';
import 'package:fakestoreapi/app/data/services/remote/internet_checker.dart';
import 'package:fakestoreapi/app/data/services/remote/productAPI.dart';
import 'package:fakestoreapi/app/data/services/service_locator.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';


import 'data/http/http.dart';

Future<void> injectRepositories({
  required Http http,
  required ProductAPI productAPI,
  required Connectivity connectivity,
  required InternetChecker internetChecker,
}) async {

  final connectivityRepository =
  ServiceLocator.instance.put<ConnectivityRepository>(
    ConnectivityRepositoryImpl(
      connectivity,
      internetChecker,
    ),
  );

  ServiceLocator.instance.put<ProductRepository>(
    ProductRepositoryImpl(
      productAPI,
      http,
    ),
  );


  await connectivityRepository.initialize();
}

class Repositories {
  Repositories._(); // coverage:ignore-line

  ///
  static ConnectivityRepository get connectivity =>
      ServiceLocator.instance.find();


  static ProductRepository  get productRepository =>
      ServiceLocator.instance.find();


}
