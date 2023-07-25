import 'package:fakestoreapi/app/domain/models/product.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
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
  String _searchTerm = '';
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductController>(context, listen: false)
          .updateProductList();
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }
  void _updateSearchTerm(String value) {
    if (_isMounted) {
      setState(() {
        _searchTerm = value;
      });
    }
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
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: _updateSearchTerm,
            ),
          ),
          Expanded(
            child: Consumer<ProductController>(
              builder: (context, productController, _) {
                List<Product> products = productController.productList;


                List<Product> filteredProducts = products.where((product) {
                  final title = product.title.toLowerCase();
                  final searchLowercase = _searchTerm.toLowerCase();
                  return title.contains(searchLowercase);
                }).toList();


                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    Product product = filteredProducts[index];
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