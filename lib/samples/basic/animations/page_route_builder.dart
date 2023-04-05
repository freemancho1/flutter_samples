import 'package:flutter/material.dart';

class PageRouteBuilderApp extends StatelessWidget {
  const PageRouteBuilderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Page1'),),
    body: Center(
      child: ElevatedButton(
        child: const Text('Go!!'),
        onPressed: () => Navigator.of(context).push<void>(_createRoute()),
      ),
    ),
  );

  Route _createRoute() => PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => const _Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(
        begin: const Offset(0, 1), end: Offset.zero,
      );
      var curveTween = CurveTween(curve: Curves.ease);
      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    }
  );
}

class _Page2 extends StatelessWidget {
  const _Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Page2'),),
    body: Center(
      child: Text(
        'Page 2!!',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}
