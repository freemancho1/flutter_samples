import 'package:flutter/material.dart';

class AnimationBuilderApp extends StatefulWidget {
  const AnimationBuilderApp({Key? key}) : super(key: key);

  @override
  State<AnimationBuilderApp> createState() => _AnimationBuilderAppState();
}

class _AnimationBuilderAppState extends State<AnimationBuilderApp>
    with SingleTickerProviderStateMixin {

  final Color beginColor = Colors.deepPurpleAccent;
  final Color endColor = Colors.deepOrangeAccent;
  final Duration duration = const Duration(milliseconds: 800);
  late AnimationController ac;
  late Animation<Color?> animation;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: duration);
    animation = ColorTween(begin: beginColor, end: endColor).animate(ac);
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Color Tween'),),
    body: Center(
      child: AnimatedBuilder(
        animation: animation,
        /// 애니메이션 대상이 되는 위젯(MaterialButton)
        builder: (context, _) => MaterialButton(
          color: animation.value,
          minWidth: 100, height: 50,
          onPressed: () => (ac.status == AnimationStatus.completed)
              ? ac.reverse() : ac.forward(),
          child: const Text('Change', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
}
