import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class ErroInternetPage extends StatelessWidget {
  const ErroInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
               AppImages.disconnected
              )
            ),
          ),
          Image.asset(
            AppImages.home,

          ),
          const SizedBox(height: 20),
        ],
      ),
    );

  }
}




