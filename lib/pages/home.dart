import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('hello World'),
          ElevatedButton(
              onPressed: () => context.go('/home/childPage/123'),
              child: const Text('前往首页子页面'))
        ],
      )),
    );
  }
}
