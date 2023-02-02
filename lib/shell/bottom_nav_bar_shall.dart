import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBarShell extends StatelessWidget {
  final Widget child;

  const BottomNavBarShell({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: '计数器'),
            BottomNavigationBarItem(icon: Icon(Icons.pages), label: '通用页面'),
          ],
          currentIndex: _calculateSelectedIndex(context),
          onTap: (idx) => _onItemTapped(idx, context)),
    );
  }

  // 计算当前菜单索引
  static int _calculateSelectedIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;

    if (location.startsWith('/counter')) {
      return 1;
    } else if (location.startsWith('/common')) {
      return 2;
    } else {
      return 0;
    }
  }

  // 点击菜单
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 1:
        GoRouter.of(context).go('/counter');
        break;
      case 2:
        GoRouter.of(context).go('/common');
        break;
      case 0:
      default:
        GoRouter.of(context).go('/home');
        break;
    }
  }
}
