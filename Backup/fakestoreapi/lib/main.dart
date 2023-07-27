import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/data/services/remote/internet_checker.dart';
import 'package:fakestoreapi/app/data/services/remote/productAPI.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/my_app.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/products/all/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/inject_repositories.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final http = Http(
    client: Client(),
    baseUrl: 'https://fakestoreapi.com',
  );

  await injectRepositories(
  http: http,
  connectivity: Connectivity(),
  internetChecker: InternetChecker(), productAPI: ProductAPI(http),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductController>(
          create: (_) => ProductController(
            Repositories.productRepository, // Aqui está a mudança
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
