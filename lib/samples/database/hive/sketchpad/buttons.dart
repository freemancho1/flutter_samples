import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_config.dart';

final Box _spBox = Hive.box(HiveCfg.tableSketchPadName);

class ClearButton extends StatelessWidget {
  const ClearButton({Key? key}) : super(key: key);

  @override
  /// Widget build(BuildContext context) => IconButton(
  ///   /// 이 부분 처리가 일반적으로는 아래와 같아 보이는데 좀 특이함
  ///   /// onPressed: () => _spBox.length == 0 ? null : _spBox.clear(),
  ///   /// **********
  ///   /// 이 방법을 사용하면, 최초에 _spBox.length는 0이기 때문에 버튼이 비활성화되고,
  ///   /// 이 상태로 이 위젯 자체가 StatelessWidget이기 때문에 변경되지 않아
  ///   /// 계속 비활성화 상태로 구현된다.
  ///   onPressed: _spBox.length == 0 ? null : () => _spBox.clear(),
  ///   icon: const Icon(Icons.delete),
  /// );
  /// 아래와 같이 구현해야 리스너가 박스의 상태를 모니터링해서 버튼을 활성화 해 준다.
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _spBox.listenable(),
    builder: (context, box, _) => IconButton(
      /// 아래와 같이하면 박스가 비어있으면 비활성화,
      /// 비어있지 않으면 클릭할 수 있고, 클릭했을 때 박스를 다 지움.
      onPressed: box.length == 0 ? null : () => box.clear(),
      icon: const Icon(Icons.delete),
    )
  );
}

class UndoButton extends StatelessWidget {
  const UndoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _spBox.listenable(),
    builder: (context, box, _) => IconButton(
      onPressed: box.length == 0 ? null : () => box.deleteAt(box.length-1),
      icon: const Icon(Icons.undo),
    )
  );
}
