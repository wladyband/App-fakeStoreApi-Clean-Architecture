import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/presentation/routes/app_routes.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _checkInternetAndRedirect();
  }

  Future<void> _checkInternetAndRedirect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Nenhuma conexão à internet, redirecionar para a tela de home
      Navigator.pushReplacementNamed(context,
          Routes.home); // Substitui a rota atual pela rota da tela de home
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.list_products,
        routes: appRoutes,
      ),
    );
  }
}
