import 'package:flutter/material.dart';

class ListProductsView extends StatefulWidget {
  const ListProductsView({Key? key}) : super(key: key);

  @override
  State<ListProductsView> createState() => _ListProductsViewState();
}

class _ListProductsViewState extends State<ListProductsView> {
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
          icon: Icon(
            Icons.favorite,
            color: Colors.white, // Define a cor do ícone do coração como branco
          ),
          onPressed: () {},
          splashColor: Colors.transparent,
          // Remove o efeito de splash ao tocar no ícone
          highlightColor: Colors.transparent,
          // Remove o efeito de highlight ao tocar no ícone
          hoverColor: Colors
              .transparent, // Remove o efeito de hover ao passar o mouse sobre o ícone (caso o app tenha suporte para mouse)
        ),
      ],
    ));
  }
}
