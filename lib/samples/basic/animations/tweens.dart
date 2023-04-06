import 'package:flutter/material.dart';

class TweensApp extends StatefulWidget {
  const TweensApp({Key? key}) : super(key: key);

  @override
  State<TweensApp> createState() => _TweensAppState();
}

class _TweensAppState extends State<TweensApp>
    with SingleTickerProviderStateMixin {

  final Duration duration = const Duration(seconds: 1);
  final double accountBalance = 1000000.0;
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration)
        /// duration 동안 controller.value가 0~1사이값으로 변경되는 동안에 호출됨
        ..addListener(() { setState(() {}); });
    /// Tween(시작과 끝을 받아 중간을 자동으로 계산해주는 위젯)으로 애니메이션을 설정하고,
    /// 해당 애니메이션의 컨트롤러로 controller를 지정함
    /// 이 경우에는 0~1000000까지 숫자가 올라갔다 내려오는 애니메이션
    animation = Tween(begin: 0.0, end: accountBalance).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Tweens Animation'),),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Column(
              children: [
                Text(
                  /// 0 ~ 1000000
                  animation.value.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  /// 0 ~ 1
                  controller.value.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.status == AnimationStatus.completed) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
            child: Text(
              controller.status == AnimationStatus.completed
                  ? 'Buy a Mansion' : 'Win Lottery'
            )
          ),
        ],
      ),
    ),
  );
}
