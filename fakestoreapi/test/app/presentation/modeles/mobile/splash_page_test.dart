import 'package:fakestoreapi/app/domain/repositories/connectivity_repository.dart';
import 'package:fakestoreapi/app/my_app.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/erro/erro_internet_page.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/produtos/all/controllers/product_controller.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/produtos/all/views/list_produts_page.dart';
import 'package:fakestoreapi/app/presentation/modules/splash_page.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// Classe de mock para o ProductController
class MockProductController extends Mock implements ProductController {}

class MockConnectivityRepository extends Mock
    implements ConnectivityRepository {
  @override
  Future<bool> get hasInternet async =>
      true; // Pode ser true ou false dependendo do teste
}

void main() {
  testWidgets('Test _init() with internet connection',
      (WidgetTester tester) async {
    final mockConnectivityRepository = MockConnectivityRepository();
    final mockProductController = MockProductController();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            Provider<ConnectivityRepository>.value(
              value: mockConnectivityRepository,
            ),
            ChangeNotifierProvider<ProductController>.value(
              // Correção aqui
              value: mockProductController,
            ),
          ],
          child: MaterialApp(
            routes: {
              Routes.init: (context) => const MyApp(),
            },
          ),
        ),
      ),
    );

    // Aguarda o próximo ciclo de renderização
    await tester.pump();

    // Verifica se _goTo(Routes.list_products) foi chamado
    expect(find.byType(SplashPage), findsOneWidget);
    await tester
        .pumpAndSettle(); // Aguarda a conclusão de futuras tarefas assíncronas
    expect(find.byType(SplashPage),
        findsNothing); // Verifica se a página foi substituída
    expect(find.byType(ListProductsPage),
        findsOneWidget); // Verifique se a próxima página foi exibida corretamente
  });

  testWidgets('Test _init() without internet connection',
      (WidgetTester tester) async {
    final mockConnectivityRepository = MockConnectivityRepository();
    when(mockConnectivityRepository.hasInternet).thenAnswer((_) async => false);

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<ConnectivityRepository>.value(
          value: mockConnectivityRepository,
          child: SplashPage(),
        ),
        routes: {
          Routes.erro: (context) => ErroInternetPage(),
          // Adicione a rota "Routes.erro" aqui
        },
      ),
    );

    // Aguarda o próximo ciclo de renderização
    await tester.pump();

    // Verifica se _goTo(Routes.erro) foi chamado
    expect(find.byType(SplashPage), findsOneWidget);
    await tester
        .pumpAndSettle(); // Aguarda a conclusão de futuras tarefas assíncronas
    expect(find.byType(SplashPage),
        findsNothing); // Verifica se a página foi substituída
    expect(find.byType(ErroInternetPage),
        findsOneWidget); // Verifique se a próxima página foi exibida corretamente
  });
}
