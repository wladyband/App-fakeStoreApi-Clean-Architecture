import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/data/repositories_implementation/product_repository_impl.dart';
import 'package:fakestoreapi/app/data/services/remote/productAPI.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/my_app.dart';
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
      ],
      child: const MyApp(),
    ),
  );
}
