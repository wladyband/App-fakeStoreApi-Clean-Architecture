import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/controllers/product_controller.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/widget/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    bool isFavorite = productController.isFavorite(widget.product);

    // Obtém o tamanho da largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Navigate to the detail page here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: widget.product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.25, // 25% da largura da tela
                  height: screenWidth * 0.25, // 25% da largura da tela
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                // Espaçamento entre a imagem e as informações
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Ajuste o tamanho da fonte conforme necessário
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: screenWidth * 0.035, // Ajuste o tamanho do ícone conforme necessário
                          ),
                          const SizedBox(width: 6),
                          // Espaço entre o ícone e o texto
                          Text(
                            widget.product.rating.rate.toString(),
                            style: TextStyle(
                                fontSize: screenWidth * 0.04, // Ajuste o tamanho da fonte conforme necessário
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500),
                          ),
                          Text(
                            " (${widget.product.rating.count} reviews)",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04, // Ajuste o tamanho da fonte conforme necessário
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500),
                          ),
                          SizedBox(width: screenWidth * 0.07), // 7% da largura da tela
                          InkWell(
                            onTap: () {
                              productController.toggleFavorite(widget.product);
                            },
                            child: Image.asset(
                              isFavorite
                                  ? AppImages.favorite_true
                                  : AppImages.favorite_false,
                              width: screenWidth * 0.065, // Ajuste o tamanho da imagem conforme necessário
                              height: screenWidth * 0.065, // Ajuste o tamanho da imagem conforme necessário
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$" + widget.product.price.toString(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // Ajuste o tamanho da fonte conforme necessário
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Divider(
                color: Colors.grey.shade200, // Cor da barrinha cinza
                thickness: 2, // Espessura da barrinha
              ),
            ),
          ],
        ),
      ),
    );
  }
}

