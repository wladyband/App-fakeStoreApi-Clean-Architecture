import 'package:fakestoreapi/app/presentation/routes/app_routes.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definir ícone e texto da barra de status como preto
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        routes: appRoutes,
      ),
    );
  }
}
