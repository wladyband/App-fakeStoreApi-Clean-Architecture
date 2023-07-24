import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded( // Ocupa o espaço disponível acima do rodapé
            child: Center(
              child: Image.asset(
               AppImages.disconnected
              )
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                Routes.list_products,
              );
            },
            child: Image.asset(
              AppImages.home,
              // Aqui você pode definir atributos como width, height, etc. para a imagem.
            ),
          ),
          SizedBox(height: 20), // Opcional: Espaçamento entre o rodapé e a parte inferior da tela
        ],
      ),
    );

  }
}




