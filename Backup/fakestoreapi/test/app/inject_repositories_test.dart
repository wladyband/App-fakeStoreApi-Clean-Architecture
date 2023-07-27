import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/data/services/service_locator.dart';
import 'package:fakestoreapi/app/inject_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:mockito/mockito.dart';
import '../mocks.mocks.dart';

void main() {
  setUp(ServiceLocator.instance.clear);
  test(
    'injectRepositories',
    () {
      final connectivity = MockConnectivity();
      final internetChecker = MockInternetChecker();
      final productAPI = MockProductAPI();

      when(connectivity.checkConnectivity()).thenAnswer(
        (_) => Future.value(ConnectivityResult.wifi),
      );
      when(connectivity.onConnectivityChanged).thenAnswer(
        (_) => const Stream.empty(),
      );

      when(internetChecker.hasInternet()).thenAnswer(
        (_) => Future.value(true),
      );

      injectRepositories(
        http: Http(
          client: MockClient(),
          baseUrl: '',
        ),
        productAPI: productAPI,
        connectivity: connectivity,
        internetChecker: internetChecker,
      );

      Repositories.connectivity;
    },
  );
}
