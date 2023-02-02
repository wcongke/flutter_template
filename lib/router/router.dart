import 'package:go_router/go_router.dart';
import 'package:flutter_template/router/routes.dart';
import 'package:flutter_template/router/shell_routes.dart';

class AppRouter {
  static final defaultRouter = GoRouter(routes: AppRoutes.routes);
  static final shellRouter =
      GoRouter(routes: AppShellRoutes.routes, initialLocation: '/home');
}
