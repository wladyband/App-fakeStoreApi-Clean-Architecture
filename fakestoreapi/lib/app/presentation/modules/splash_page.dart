import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
    final ConnectivityRepository connectivityRepository = context.read();

    final hasInternet = await connectivityRepository.hasInternet;

    if (!hasInternet) {
      _goTo(Routes.erro);
    }
    if (hasInternet) {

      if (mounted) {
        _goTo(Routes.list_products);
      }
    }
  }

  _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {



    return const Scaffold(
      body: Center(
        child:
        SizedBox(width: 80, height: 80, child: CircularProgressIndicator()),
      ),
    );
  }
}
