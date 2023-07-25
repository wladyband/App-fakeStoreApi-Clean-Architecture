import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:fakestoreapi/app/data/repositories_implementation/product_repository_impl.dart';
import 'package:fakestoreapi/app/data/services/remote/internet_checker.dart';
import 'package:fakestoreapi/app/data/services/remote/productAPI.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';
import 'package:fakestoreapi/app/my_app.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

void main() {
  final http = Http(
    client: Client(),
    baseUrl: 'https://fakestoreapi.com',
  );
  final productAPI = ProductAPI(http);
  runApp(
    MultiProvider(
      providers: [
        Provider<ProductRepository>(
          create: (_) => ProductRepositoryImpl(
            productAPI,
            http,
          ),
        ),
        ChangeNotifierProvider<ProductController>(
          create: (_) => ProductController(
            Provider.of<ProductRepository>(_, listen: false),
          ),
        ),
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(),
            InternetChecker(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
