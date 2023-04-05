import 'package:flutter/material.dart';


class CustomTweenDemo extends StatefulWidget {
    const CustomTweenDemo({super.key});
    static const String routeName = 'basics/custom_tweens';

    @override
    State<CustomTweenDemo> createState() => CustomTweenDemoState();
}

class CustomTweenDemoState
    extends State<CustomTweenDemo>
    with SingleTickerProviderStateMixin {
    static const Duration duration = Duration(seconds: 10);
    static const String message = loremIpsum;
    late final AnimationController controller;
    late final Animation<String> animation;

    @override
    void initState() {
        super.initState();
        controller = AnimationController(vsync: this, duration: duration);
        animation = TypewriterTween(end: message).animate(controller);
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('Custom Tween'),
            actions: [
                MaterialButton(
                    textColor: Colors.white,
                    onPressed: () {
                        if (controller.status == AnimationStatus.completed) {
                            controller.reverse().whenComplete(() {
                                setState(() {});
                            });
                        } else {
                            controller.forward().whenComplete(() {
                                setState(() {});
                            });
                        }
                    },
                    child: Text(
                        controller.status == AnimationStatus.completed
                            ? 'Delete Essay' : 'Write Essay'
                    )
                )
            ]
        ),
        body: SafeArea(
            child: Container(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AnimatedBuilder(
                                            animation: animation,
                                            builder: (context, child) => Text(
                                                animation.value,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'SpecialElite'
                                                )
                                            ),
                                        )
                                    )
                                )
                            )
                        ],
                    ),
                ),
            )
        )
    );
}


class TypewriterTween extends Tween<String> {
    TypewriterTween({String begin = '', String end = ''}): super(begin: begin, end: end);

    @override
    String lerp(double t) {
        var cutoff = (end!.length * t).round();
        return end!.substring(0, cutoff);
    }
}

const String loremIpsum = '''
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim
ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque
porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur
adipisci[ng] velit, sed quia non-numquam [do] eius modi tempora inci[di]dunt, ut
labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam,
quis nostrum[d] exercitationem ullam corporis suscipit laboriosam, nisi ut
aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in
ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui
dolorem eum fugiat, quo voluptas nulla pariatur?
''';