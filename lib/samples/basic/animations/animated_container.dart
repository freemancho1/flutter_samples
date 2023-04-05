import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  late Color color;
  late double borderRadius;
  late double margin;

  double generateBorderRadius() => Random().nextDouble() * 64;
  double generateMargin() => Random().nextDouble() * 64;
  /// 랜덤 색상 만들기
  Color generateColor() => Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

  @override
  void initState() {
    super.initState();
    change();
  }

  void change() => setState(() {
    color = generateColor();
    borderRadius = generateBorderRadius();
    margin = generateMargin();
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Animated Container'),),
    body: Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 128, height: 128,
              child: AnimatedContainer(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => change(),
            child: const Text('Change'),
          ),
        ],
      ),
    ),
  );
}
