import 'package:flutter/material.dart';


class AnimatedBuilderDemo extends StatefulWidget {
    const AnimatedBuilderDemo({super.key});
    static const String routeName = 'basics/animated_builder';

    @override
    State<AnimatedBuilderDemo> createState() => AnimatedBuilderDemoState();
}


class AnimatedBuilderDemoState
    extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {

    static const Color beginColor = Colors.deepPurple;
    static const Color endColor = Colors.deepOrange;
    Duration duration = const Duration(milliseconds: 800);
    late AnimationController controller;
    late Animation<Color?> animation;

    @override
    void initState() {
        super.initState();

        controller = AnimationController(vsync: this, duration: duration);
        animation = ColorTween(begin: beginColor, end: endColor).animate(controller);
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Animated Builder")),
        body: Center(
            child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) => MaterialButton(
                    color: animation.value,
                    minWidth: 100, height: 50,
                    child: child,
                    onPressed: () {
                        if (controller.status == AnimationStatus.completed) {
                            controller.reverse();
                        } else {
                            controller.forward();
                        }
                    }
                ),
                child: const Text(
                    'Change Color',
                    style: TextStyle(color: Colors.white),
                ),
            ),
        ),
    );
}