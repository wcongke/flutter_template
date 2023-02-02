import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage {
  static final _curveTween = CurveTween(curve: Curves.easeIn);

  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            child: child,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                    opacity: animation.drive(_curveTween), child: child));
}
