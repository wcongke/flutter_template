import 'package:go_router/go_router.dart';
import 'package:flutter_template/shell/bottom_nav_bar_shall.dart';
import 'package:flutter_template/router/fade_transition_page.dart';
import 'package:flutter_template/pages/home.dart';
import 'package:flutter_template/pages/counter.dart';
import 'package:flutter_template/pages/common.dart';

class AppShellRoutes {
  static final routes = [
    ShellRoute(
        builder: (context, state, child) {
          return BottomNavBarShell(child: child);
        },
        routes: [
          GoRoute(
              path: '/home',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                    key: state.pageKey, child: const HomePage());
              },
              routes: [
                GoRoute(
                  path: 'childPage/:pageId',
                  builder: (context, state) {
                    return CommonPage(
                        title: '首页子页面',
                        content: state.params['pageId'] as String);
                  },
                ),
              ]),
          GoRoute(
            path: '/counter',
            pageBuilder: (context, state) {
              return FadeTransitionPage(
                  key: state.pageKey, child: const CounterPage());
            },
          ),
          GoRoute(
            path: '/common',
            pageBuilder: (context, state) {
              return FadeTransitionPage(
                  key: state.pageKey,
                  child: const CommonPage(
                    title: '通用页面',
                    content: '通用页面内容',
                  ));
            },
          )
        ])
  ];
}
