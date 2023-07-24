import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({Key? key}) : super(key: key);

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        _init();
      },
    );
  }

  Future<void> _init() async {
    final ProductRepository productRepository = context.read();
    List<Product> productList = await productRepository.getProductData();
    setState(() {
      products = productList;
    });
  }


  @override
  Widget build(BuildContext context) {
    final _productController = Provider.of<ProductController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset(
              AppImages.favorite_false,
              width: 24,
              height: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Anything',
                // Texto de dica no campo de busca
                prefixIcon: Icon(Icons.search),
                // Ícone à esquerda do campo de busca
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length, // Correção aqui
              itemBuilder: (context, index) {
                Product product = products[index]; // Correção aqui
                return ListTile(
                  title: Text(product.title),
                  // Adicione outros detalhes do produto que deseja exibir aqui.
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
