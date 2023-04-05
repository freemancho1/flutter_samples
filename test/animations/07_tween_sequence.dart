import 'package:flutter/material.dart';


class TweenSequenceDemo extends StatefulWidget {
    const TweenSequenceDemo({super.key});
    static const String routeName = 'basics/chaining_tweens';

    @override
    State<TweenSequenceDemo> createState() => TweenSequenceDemoState();
}

class TweenSequenceDemoState
    extends State<TweenSequenceDemo>
    with SingleTickerProviderStateMixin {

    static const Duration duration = Duration(seconds: 30);
    late final AnimationController controller;
    late final Animation<Color?> animation;

    static final colors = [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple,
    ];

    @override
    void initState() {
        super.initState();

        final sequenceItems = <TweenSequenceItem<Color?>>[];
        final int numberOfColors = colors.length;

        for (int i=0; i<numberOfColors; i++) {
            final MaterialColor beginColor = colors[i];
            final MaterialColor endColor = colors[(i+1) % numberOfColors];
            final double weight = 1 / numberOfColors;
            sequenceItems.add(
                TweenSequenceItem<Color?>(
                    tween: ColorTween(begin: beginColor, end: endColor),
                    weight: weight,
                )
            );
        }

        controller = AnimationController(duration: duration, vsync: this);
        animation = TweenSequence<Color?>(sequenceItems).animate(controller);
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Tween Sequences')),
        body: Center(
            child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) => MaterialButton(
                    color: animation.value,
                    onPressed: () async {
                        await controller.forward();
                        controller.reset();
                    },
                    child: child,
                ),
                child: const Text(
                    'Animate',
                    style: TextStyle(color: Colors.white)
                )
            )
        )
    );
}