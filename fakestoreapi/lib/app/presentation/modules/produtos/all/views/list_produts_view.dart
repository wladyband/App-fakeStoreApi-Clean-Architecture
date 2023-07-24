import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/global/widget/product_widget.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({Key? key}) : super(key: key);

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductController>(context, listen: false).updateProductList();
    });
  }

  @override
  Widget build(BuildContext context) {

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
            child: Consumer<ProductController>(
              builder: (context, productController, _) {
                List<Product> products = productController.productList;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Product product = products[index];
                    return ProductWidget(product: product);
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
