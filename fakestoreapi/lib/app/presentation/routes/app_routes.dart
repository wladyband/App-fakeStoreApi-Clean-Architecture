
import 'package:fakestoreapi/app/presentation/modules/home/home_view.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/views/list_produts_view.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/register/views/product_registration_form.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.list_products: (context) => ListProductsView(),
    Routes.home: (context) => ListProductsView(),
    Routes.product_registration: (context) => const ProductRegistrationForm(),
  };
}