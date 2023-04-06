import 'package:flutter/material.dart';

class ButtonsApp extends StatelessWidget {
  const ButtonsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Buttons'),),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ElevatedButton(
                onLongPress: () {},
                onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                    content: Text('Elevated Button Click',),
                    duration: Duration(seconds: 1),
                )),
                style: ElevatedButton.styleFrom(
                  /// 크기는 min/maxSize를 지정할 수 있으며, 고정할 수도 있음
                  /// 가급적 min/maxSize 이용
                  /// fixedSize: const Size(200, 50),
                  minimumSize: const Size(180, 45),
                  animationDuration: const Duration(seconds: 5),
                ),
                child: const Text('ElevatedButton'),
              ),
            ]
          ),
        ],
      ),
    )
  );
}
