import 'package:fakestoreapi/app/data/services/service_locator.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void injectTestRepositories({
  bool defaultStubs = true,
}) {
  ServiceLocator.instance.clear();

  ServiceLocator.instance.put<ConnectivityRepository>(
    MockConnectivityRepository(),
  );

  ServiceLocator.instance.put<ProductRepository>(
    MockProductRepository(),
  );
}
