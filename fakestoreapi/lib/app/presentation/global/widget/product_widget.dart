import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  bool isFavorite = false; // Variável que determina se o produto é um favorito ou não

  @override
  void initState() {
    super.initState();
    checkIfFavorite(); // Verifica se o produto é um favorito ao inicializar o widget
  }

  void checkIfFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteProducts = prefs.getStringList('favoriteProducts') ?? [];
    setState(() {
      isFavorite = favoriteProducts.contains(widget.product.id);
    });
  }

  void toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteProducts = prefs.getStringList('favoriteProducts') ?? [];
    String productId = widget.product.id.toString(); // Converta o ID do produto para String
    if (isFavorite) {
      favoriteProducts.remove(productId);
    } else {
      favoriteProducts.add(productId);
    }
    await prefs.setStringList('favoriteProducts', favoriteProducts);
    setState(() {
      isFavorite = !isFavorite;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5, right: 26, left: 26),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100, // Ajuste o tamanho da imagem conforme necessário
                height: 100,
                child: Image.network(
                  widget.product.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              // Espaçamento entre a imagem e as informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        SizedBox(width: 6), // Espaço entre o ícone e o texto
                        Text(
                          widget.product.rating.rate.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500),
                        ),
                        Text(
                          " (${widget.product.rating.count} reviews)",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500),
                        ),
                        SizedBox(width: 27),
                        InkWell(
                          onTap: toggleFavorite, // Chama o método para alternar o status de favorito
                          child: Image.asset(
                            isFavorite ? AppImages.favorite_true : AppImages.favorite_false,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$" + widget.product.price.toString(),
                      style: TextStyle(
                        fontSize: 20,
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
    );
  }
}
