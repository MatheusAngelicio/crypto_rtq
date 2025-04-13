import 'package:crypto_rtq/core/config/app_routes.dart';
import 'package:crypto_rtq/presentation/views/details/arguments/crypto_detail_arguments.dart';
import 'package:crypto_rtq/presentation/views/details/crypto_detail_page.dart';
import 'package:crypto_rtq/presentation/views/home/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.cryptoDetail,
        name: AppRoutes.cryptoDetailName,
        builder: (context, state) {
          final args = state.extra as CryptoDetailArguments;
          return CryptoDetailPage(arguments: args);
        },
      ),
    ],
  );
}
