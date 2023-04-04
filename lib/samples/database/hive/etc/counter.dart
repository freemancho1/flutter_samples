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
            /// FAB를 2개 이상 사용할 경우 동작은 잘 되는듯 보이지만,
            /// Flutter에서 애니메이션 처리 등을 위해 만든 HeroWidget 형태를 띠고 있어
            /// 각각 고유한 `heroTag`를 지정해야 함
            FloatingActionButton(
              /// 이를 지정하지 않으면 `heroTag` 충돌로 에러가 발생함.
              heroTag: 'decrement button',
              onPressed: () {
                /// 현재값을 읽어와 1을 더해 다시 저장함.
                int currValue = _counterBox.get(_accKey, defaultValue: 0)!;

                /// 여기서 변경된 값이 위에 리스너에 감지되 출력된다.
                _counterBox.put(_accKey, currValue - 1);
              },
              tooltip: 'Decrement',
              child: const Icon(MdiIcons.minusCircle),
            ),
            const SizedBox(
              width: 8,
            ),
            FloatingActionButton(
              heroTag: 'increment button',
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
