import 'package:fakestoreapi/app/inject_repositories.dart';
import 'package:fakestoreapi/app/presentation/global/ppp_images.dart';
import 'package:fakestoreapi/app/presentation/modules/mobile/erro/erro_internet_page.dart';
import 'package:fakestoreapi/app/presentation/modules/splash_page.dart';
import 'package:fakestoreapi/app/presentation/routes/app_routes.dart';
import 'package:fakestoreapi/app/presentation/routes/routes.dart';
import 'package:fakestoreapi/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../inject_test_repositories.dart';

void main() {
  setUp(
        () {
      injectTestRepositories();
    },
  );

  testWidgets(
    'SplashView > erro',
        (tester) async {
      // Simula a falta de conexão com a internet
      when(Repositories.connectivity.hasInternet).thenReturn(false);

      // Constrói e mostra o widget que está sendo testado (SplashPage)
      await tester.pumpWidget(
        Root(
          appRoutes: {
            ...appRoutes,
            Routes.erro: (_) => ErroInternetPage(), // Página de erro
          },
        ),
      );

      // Verifica se a SplashPage está presente e é única na árvore de widgets
      expect(
        find.byType(SplashPage),
        findsOneWidget,
      );

      // Executa as animações e tarefas assíncronas até que a tela esteja pronta
      await tester.pumpAndSettle();

      // Verifica se a página de erro (ErroInternetPage) foi renderizada
      expect(
        find.byType(ErroInternetPage),
        findsOneWidget,
      );

    },
  );
}
