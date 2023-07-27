import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/products/all/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    bool isFavorite = productController.isFavorite(product);

    // Obtém a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products Details",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.075),
            child: InkWell(
              onTap: () {
                productController.toggleFavorite(product);
              },
              child: Image.asset(
                isFavorite ? AppImages.favorite_true : AppImages.favorite_false,
                width: screenWidth * 0.065,
                height: screenWidth * 0.065,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.05),
              child: SizedBox(
                width: screenWidth * 0.8,
                height: screenWidth * 0.77,
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.05,
                  right: screenWidth * 0.03,
                  left: screenWidth * 0.03),

              child: Text(
                product.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.05,
                  right: screenWidth * 0.03,
                  left: screenWidth * 0.03),

              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: screenWidth * 0.035,
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    product.rating.rate.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    " (${product.rating.count} reviews)",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.2,
                  ),
                  Text(
                    "\$" + product.price.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Image.asset(
                    AppImages.format_align_left,
                    width: screenWidth * 0.06, // 6% da largura da tela
                    height: screenWidth * 0.06, // 6% da largura da tela
                  ),
                  onPressed: () {},
                ),
                Text(
                  "${product.category}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% da largura da tela
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                IconButton(
                  icon: Icon(Icons.format_align_justify),
                  onPressed: () {
                    // Ação quando o ícone é pressionado
                  },
                ),
                Expanded(
                  child: Text(
                    "${product.description}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // 4% da largura da tela
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
