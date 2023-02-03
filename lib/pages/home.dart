import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('hello World'),
          ElevatedButton(
              onPressed: () => context.go('/home/childPage/123'),
              child: const Text('Go to home child page')),
          ElevatedButton(
              onPressed: () => context.go('/webview/?fromPage=/home'),
              child: const Text('webview'))
        ],
      )),
    );
  }
}
