import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_samples/samples/database/hive/hive_config.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  /// main.dart에서 오픈한 박스를 쉽게 접근하기 위해 설정함.
  final Box<int> _counterBox = Hive.box<int>(HiveCfg.tableCounterName);
  /// 하이브 박스에 접속에 읽어올 Key
  final String _accKey = 'counter';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Hive - Counter'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '클릭한 횟 수:',
            style: TextStyle(fontSize: 16, color: Colors.deepOrange),
          ),
          ValueListenableBuilder(
            valueListenable: _counterBox.listenable(),
            builder: (context, counterBox, _) => Text(
              /// 저장된 값이 변경되면 변경된 값을 읽어와 출력함.
              '${counterBox.get(_accKey, defaultValue: 0)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            /// 현재값을 읽어와 1을 더해 다시 저장함.
            int currValue = _counterBox.get(_accKey, defaultValue: 0)!;
            /// 여기서 변경된 값이 위에 리스너에 감지되 출력된다.
            _counterBox.put(_accKey, currValue - 1);
          },
          tooltip: 'Decrement',
          child: const Icon(MdiIcons.minusCircle),
        ),
        FloatingActionButton(
          onPressed: () {
            int currValue = _counterBox.get(_accKey, defaultValue: 0)!;
            _counterBox.put(_accKey, currValue + 1);
          },
          tooltip: 'Increment',
          child: const Icon(MdiIcons.plusCircle),
        ),
      ],
    ),
  );
}
