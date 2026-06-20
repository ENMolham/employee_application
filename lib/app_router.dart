import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:employee_application/Features/Auth/login/presentation/login_page.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/presentation/detailes_transactions_page.dart';
import 'package:employee_application/Features/User/transactions_page/presentation/transactions_page.dart';
import 'package:employee_application/injection.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String login = '/login';
  static const String transactions = '/transactions';
  static String transactionDetails(String id) => '/transactions/details/$id';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: (context, state) {
    final prefs = getIt<SharedPreferencesUtils>();
    final isLoggedIn = prefs.getUserName().isNotEmpty;
    final isLoginPage = state.matchedLocation == AppRoutes.login;
    if (!isLoggedIn && !isLoginPage) {
      return AppRoutes.login;
    }
    if (isLoggedIn && isLoginPage) {
      return AppRoutes.transactions;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.transactions,
      builder: (context, state) {
        final prefs = getIt<SharedPreferencesUtils>();
        return TransactionsPage(
          nameUser: prefs.getUserName(),
          imageUserUrl: prefs.getImageUrl(),
          governmentEntityUser: prefs.getGovernmentEntity(),
        );
      },
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            return DetailesTransactionsPage(id: state.pathParameters['id']!);
          },
        ),
      ],
    ),
  ],
);
