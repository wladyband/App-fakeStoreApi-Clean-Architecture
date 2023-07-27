
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/services/remote/internet_checker.dart';
import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';
import 'package:mockito/annotations.dart';
@GenerateMocks(
  [
    Connectivity,
    ConnectivityRepository,
    InternetChecker,
  ],
)
export 'mocks.mocks.dart';