
import 'package:fakestoreapi/app/my_app.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/erro/erro_internet_page.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/produtos/all/views/list_produts_page.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/produtos/widget/product_details_page.dart';
import 'package:fakestoreapi/app/presentation/modules/splash_page.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.init: (context) => const MyApp(),
    Routes.splash_page: (context) => const SplashPage(),
    Routes.list_products: (context) => const ListProductsPage(),
    Routes.erro: (context) => const ErroInternetPage(),

  };
}