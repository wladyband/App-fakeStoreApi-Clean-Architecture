import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/widget/favorite_products_page.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/widget/product_widget.dart';
import 'package:fakestoreapi/app/presentation/modules/produtos/all/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({Key? key}) : super(key: key);

  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  bool noResultsFound = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductController>(context, listen: false)
          .updateProductList();
      Provider.of<ProductController>(context, listen: false).init();
    });
  }

  @override
  void dispose() {
    Provider.of<ProductController>(context, listen: false).dispose();
    super.dispose();
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteProductsPage(), // Defina a tela de favoritos aqui
                ),
              );
            },
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
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (value) {
                Provider.of<ProductController>(context, listen: false)
                    .updateSearchTerm(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<ProductController>(
              builder: (context, productController, _) {
                List<Product> products = productController.productList;

                List<Product> filteredProducts = products.where((product) {
                  final title = product.title.toLowerCase();
                  final searchLowercase =
                      productController.searchTerm.toLowerCase();
                  return title.contains(searchLowercase);
                }).toList();

                noResultsFound = filteredProducts.isEmpty;
                if (noResultsFound) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 200,
                        height: 217,
                        child: Image.asset(AppImages.empty),
                      )
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      Product product = filteredProducts[index];
                      return ProductWidget(product: product);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
