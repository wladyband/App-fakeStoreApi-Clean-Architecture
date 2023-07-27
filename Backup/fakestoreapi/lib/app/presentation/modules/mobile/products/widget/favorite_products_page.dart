import 'package:fakestoreapi/app/domain/models/Rating.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/products/all/controllers/product_controller.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/products/widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/product.dart';

class FavoriteProductsPage extends StatefulWidget {
  const FavoriteProductsPage({Key? key}) : super(key: key);

  @override
  State<FavoriteProductsPage> createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  @override
  Widget build(BuildContext context) {
    final productController =
        Provider.of<ProductController>(context, listen: false);
    final favoriteProducts = productController.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop(); // Retorna para a tela anterior
          },
        ),
        title: const Text(
          'Favorited Products',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final productId = favoriteProducts[index];
          final product = productController.productList.firstWhere(
            (p) => p.id.toString() == productId,
            orElse: () => const Product(
              id: 0,
              title: 'Unknown',
              description: 'No description',
              image: 'default_image_url',
              price: 0.0,
              rating: Rating(
                  rate: 0.0,
                  count: 0), // Crie uma instância de Rating com valores padrão
            ),
          );
          return ProductWidget(product: product);
        },
      ),
    );
  }
}
