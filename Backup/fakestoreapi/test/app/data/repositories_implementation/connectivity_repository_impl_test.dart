import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fakestoreapi/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';

void main() {
  group(
    'ConnectivityRepositoryImpl >',
    () {
      late ConnectivityRepositoryImpl repository;
      late MockConnectivity connectivity;
      late MockInternetChecker internetChecker;

      setUp(
        () {
          connectivity = MockConnectivity();
          internetChecker = MockInternetChecker();

          repository = ConnectivityRepositoryImpl(
            connectivity,
            internetChecker,
          );
        },
      );

      test(
        'hasInternet > not initialized',
        () async {
          when(
            connectivity.checkConnectivity(),
          ).thenAnswer(
            (_) async => ConnectivityResult.wifi,
          );

          when(
            internetChecker.hasInternet(),
          ).thenAnswer(
            (_) async => true,
          );

          when(
            connectivity.onConnectivityChanged,
          ).thenAnswer(
            (_) => const Stream.empty(),
          );
          final hasInternet = await repository.hasInternet;
          expect(hasInternet, isTrue);
        },
      );

      test(
        'onConnectivityChanged',
        () async {
          when(connectivity.checkConnectivity()).thenAnswer(
            (_) async => ConnectivityResult.none,
          );
          when(connectivity.onConnectivityChanged).thenAnswer(
            (_) => Stream.fromIterable(
              [
                ConnectivityResult.wifi,
                ConnectivityResult.none,
                ConnectivityResult.mobile,
              ],
            ),
          );
          final hasInternet = await repository.hasInternet;
          expect(hasInternet, isFalse);
        },
      );
    },
  );
}
