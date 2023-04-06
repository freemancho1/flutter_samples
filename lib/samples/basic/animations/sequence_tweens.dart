import 'package:flutter/material.dart';

class SequenceTweensApp extends StatefulWidget {
  const SequenceTweensApp({Key? key}) : super(key: key);

  @override
  State<SequenceTweensApp> createState() => _SequenceTweensAppState();
}

class _SequenceTweensAppState extends State<SequenceTweensApp>
    with SingleTickerProviderStateMixin {

  final Duration duration = const Duration(seconds: 10);
  late final AnimationController ac;
  late final Animation<Color?> animation;

  final colors = const [
    Colors.red, Colors.orange, Colors.yellow, Colors.green,
    Colors.blue, Colors.indigo, Colors.purple, Colors.brown
  ];

  @override
  void initState() {
    super.initState();

    final List<TweenSequenceItem<Color?>> sequenceItems = [];
    final int numberOfColors = colors.length;
    final double weight = 1 / numberOfColors;

    for (int i=0; i<numberOfColors; i++) {
      MaterialColor beginColor = colors[i];
                               /// 마지막 이후 처음(0)으로 가는 연산 참조
      MaterialColor endColor = colors[(i+1) % numberOfColors];
      sequenceItems.add(
        TweenSequenceItem<Color?>(
          tween: ColorTween(begin: beginColor, end: endColor),
          /// 이 Tween이 전체 Tween에서 차지하는 비중
          /// 지금은 다 동일 함
          weight: weight,
        )
      );
    }

    ac = AnimationController(vsync: this, duration: duration);
    animation = TweenSequence<Color?>(sequenceItems).animate(ac);
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sequence Tween'),),
    body: Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) => MaterialButton(
          color: animation.value,
          /// 애니메이션 초기화(ac.reset())
          onPressed: () => ac.forward().whenComplete(() => ac.reset()),
          /// 이렇게도 할 수 있
          /// onPressed: () async {
          ///   await ac.forward();
          ///   ac.reset();
          /// },
          child: const Text(
            'Animate',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
