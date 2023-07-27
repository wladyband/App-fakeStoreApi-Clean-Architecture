
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/http/http.dart';
import 'package:fakestoreapi/app/data/services/remote/internet_checker.dart';
import 'package:fakestoreapi/app/data/services/remote/productAPI.dart';
import 'package:fakestoreapi/app/domain/repositories/ProductRepository.dart';
import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
@GenerateMocks(
  [
    Client,
    Http,
    Connectivity,
    ConnectivityRepository,
    ProductRepository,
    InternetChecker,
    ProductAPI
  ],
)
export 'mocks.mocks.dart';