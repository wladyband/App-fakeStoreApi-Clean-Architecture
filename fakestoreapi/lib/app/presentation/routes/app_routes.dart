
import 'package:fakestoreapi/app/presentation/home/home_view.dart';
import 'package:fakestoreapi/app/presentation/produtos/register/views/product_registration_form.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const HomeView(),
    Routes.product_registration: (context) => const ProductRegistrationForm(),

  };
}