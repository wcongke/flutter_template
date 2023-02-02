import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  const CommonPage({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('hello $content')],
      )),
    );
  }
}
