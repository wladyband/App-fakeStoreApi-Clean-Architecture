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
  @override
  void initState() {
    super.initState();
    Provider.of<ProductController>(context, listen: false).updateProductList();
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
              // Navega para a tela de favoritos quando o ícone é pressionado
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteProductsPage(),
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
                // Atualiza o termo de busca na classe controladora quando o usuário digita no campo de busca
                Provider.of<ProductController>(context, listen: false)
                    .updateSearchTerm(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<ProductController>(
              builder: (context, productController, _) {
                // Obtém a lista de produtos filtrados da classe controladora
                List<Product> filteredProducts =
                productController.getFilteredProducts();
                bool isLoading = productController.isLoading();
                if (!isLoading && filteredProducts.isEmpty) {
                  return Center(
                    child: Container(
                      width: 200,
                      height: 217,
                      child: Image.asset(AppImages.empty),
                    ),
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
