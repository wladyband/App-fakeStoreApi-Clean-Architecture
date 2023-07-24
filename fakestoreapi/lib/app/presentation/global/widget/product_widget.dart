import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
                          onTap: () {

                            print("Imagem clicada!");
                          },
                          child: Image.asset(AppImages.favorite_false,
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
