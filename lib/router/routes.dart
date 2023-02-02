import 'package:go_router/go_router.dart';
import 'package:flutter_template/pages/home.dart';
import 'package:flutter_template/pages/counter.dart';
import 'package:flutter_template/pages/common.dart';

class AppRoutes {
  static final routes = [
    GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: 'counter',
            builder: (context, state) {
              return const CounterPage();
            },
          ),
          GoRoute(
            path: 'common',
            builder: (context, state) {
              return const CommonPage(title: '通用页面', content: '通用页面');
            },
          )
        ])
  ];
}
