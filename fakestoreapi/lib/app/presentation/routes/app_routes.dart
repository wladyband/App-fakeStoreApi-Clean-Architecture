

import 'package:fakestoreapi/app/presentation/modules/home/home_view.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/views/list_produts_page.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/widget/product_details_page.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.list_products: (context) => ListProductsPage(),
    Routes.home: (context) => HomeView(),
  };
}